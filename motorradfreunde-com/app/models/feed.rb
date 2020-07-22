class Feed

  extend Enumerize

  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :poi
  has_many :linked_articles, dependent: :destroy
  has_many :posts,           dependent: :destroy

  attr_reader :xml_doc

  field :import_as,    type: String, default: 'linked_article'
  field :build_at,     type: DateTime
  field :copyright,    type: String
  field :description,  type: String
  field :feed_url,     type: String
  field :image_link,   type: String
  field :image_title,  type: String
  field :image_url,    type: String
  field :language,     type: String
  field :published_at, type: DateTime
  field :title,        type: String
  field :url,          type: String

  enumerize :import_as, in: %w(linked_article post), predicates: { prefix: true }

  validates :feed_url, presence: true, uniqueness: true
  validates :title,    presence: true, uniqueness: true

  before_validation :update_feed_data

  def fetch_and_parse
    return @xml_doc if @xml_doc
    file = open(self.feed_url)
    @xml_doc = Nokogiri::XML file
    file.close
    @xml_doc
  end

  def to_s
    self.title
  end

  def update_feed_data
    doc = self.fetch_and_parse
    self.title        ||= doc.at_css('channel, feed > title')&.text
    self.copyright    ||= doc.at_css('channel, feed > copyright')&.text
    self.description  ||= doc.at_css('channel, feed > description')&.text
    self.image_link   ||= doc.at_css('channel, feed > image link')&.text
    self.image_title  ||= doc.at_css('channel, feed > image title')&.text
    self.image_url    ||= doc.at_css('channel, feed > image url')&.text
    self.language     ||= doc.at_css('channel, feed > language')&.text
    self.url          ||= doc.at_css('channel, feed > link')&.text
    self.build_at     = doc.at_css('channel, feed > lastBuildDate, updated')&.text
    self.published_at = doc.at_css('channel, feed > pubDate, updated')&.text
    self
  end

  def import_feed_items
    doc = self.fetch_and_parse
    doc.css('channel item, feed entry').each do |item|
      feed_item = case self.import_as
      when 'linked_article'
        self.linked_articles.build feed_item: item, poi: poi
      when 'post'
        self.posts.build feed_item: item, poi: poi
      end
      feed_item.save
    end
  end

end
