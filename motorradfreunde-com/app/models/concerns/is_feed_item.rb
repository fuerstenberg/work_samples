module Concerns::IsFeedItem
  extend ActiveSupport::Concern
  include ActionView::Helpers::SanitizeHelper

  included do

    belongs_to :feed
    belongs_to :poi

    field :active,       type: Boolean, default: true
    field :author,       type: String
    field :categories,   type: String
    field :content,      type: String
    field :description,  type: String
    field :guid,         type: String
    field :published_at, type: DateTime
    field :raw_data,     type: String, default: ''
    field :title,        type: String
    field :url,          type: String

    validates :feed_id, presence: true
    validates :poi,     presence: true
    validates :title,   presence: true
    validates :url,     presence: true, uniqueness: true
  end

  def feed_item=(feed_node)
    self.title        ||= feed_node&.at_css('title')&.text
    self.url          ||= feed_node&.at_css('link')&.text
    self.guid         ||= feed_node&.at_css('guid, id')&.text
    self.author       ||= feed_node&.at_css('author')&.text
    self.author       ||= feed_node&.at_css('dc|creator')&.text rescue nil
    self.published_at ||= feed_node&.at_css('pubDate, published')&.text
    self.categories   ||= feed_node&.at_css('category')&.text
    self.description  ||= sanitize Nokogiri::HTML(feed_node&.at_css('summary')&.text)&.text
    self.description  ||= sanitize Nokogiri::HTML(feed_node&.at_css('description')&.text)&.text
    self.content      ||= sanitize Nokogiri::HTML(feed_node&.at_css('content')&.text)&.text
    self.content      ||= sanitize Nokogiri::HTML(feed_node&.at_css('content|encoded')&.text)&.text
    image_urls = []
    image_urls << feed_node&.at_css('media|content')&.attributes["url"]&.value rescue nil
    image_urls << feed_node&.at_css('media|thumbnail')&.attributes["url"]&.value rescue nil
    image_urls << Nokogiri::XML::DocumentFragment.parse(feed_node.at_css('description')&.content).css('img').attr('src') rescue nil
    image_urls << Nokogiri::XML::DocumentFragment.parse(feed_node.at_css('content|encoded').content).css('img').attr('src') rescue nil

    image_urls.flatten.compact.each do |image|
      images.build remote_file_url: image
    end

    parse_open_graph

    images.each do |image|
      image.delete if image.invalid?
    end
  end

  def preview(format = nil)
    self.images.sort_by(&:size).reverse&.first&.file&.url format # || ''
  end

  private

  def parse_open_graph
    return if url.blank?
    og = OpenGraph.new url
    self.title = og.title # => "Open Graph protocol"
    type = og.type # => "website"
    # og.url # => "http://ogp.me/"
    self.description ||= og.description # => "The Open Graph protocol enables any web page to become a rich object in a social graph."
    og.images.each do |image|
      images.build remote_file_url: image # => ["http://ogp.me/logo.png"]
    end
  end

end
