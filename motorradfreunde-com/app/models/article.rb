class Article

  include Mongoid::Document
  include Mongoid::Search
  include Mongoid::Timestamps

  include Concerns::EmbedsManyComments
  include Concerns::EmbedsManyImages
  include Concerns::HasDefaultScopes
  include Concerns::HasImpressions
  include Concerns::HasManyActivities
  include Concerns::HasMetaMethods

  belongs_to :user

  field :title,     type: String
  field :body,      type: String
  field :http,      type: String
  field :active,    type: Boolean, default: false
  field :news,      type: Boolean, default: false
  field :source,    type: String
  field :body_html, type: String

  validates :title, presence: true
  validates :body,  presence: { if: :is_article? }

  acts_as_url :title, url_attribute: :slug

  scope :active, -> { where(active: true) }

  search_in :title, :body, :description

  # TODO: auto_html
  # auto_html_for :body do
  #   html_escape
  #   redcarpet
  #   image
  #   youtube     width: 600, height: 450
  #   google_map  width: 600, height: 450, link_text: ""
  #   vimeo       width: 600, height: 450
  #   link        target: "_blank", rel: "nofollow"
  # end

  def is_article?
    self.class == Article
  end

  def to_s
    title
  end

  def to_keywords
    self.title.split(' ').select{ |str| str.size > 3 }.join(',') rescue nil
  end

  def to_description
    self.body[0,155] rescue ""
  end

  def to_param
    slug
  end

end
