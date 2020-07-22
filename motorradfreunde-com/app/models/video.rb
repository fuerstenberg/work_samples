class Video

  include Mongoid::Document
  include Mongoid::Search
  include Mongoid::Timestamps

  include Concerns::HasImpressions
  include Concerns::HasMetaMethods
  include Concerns::HasManyActivities

  field :active,                  type: Boolean, default: false
  field :author_name,             type: String
  field :author_uri,              type: String
  field :description,             type: String
  field :duration,                type: Integer
  field :player_url,              type: String
  field :title,                   type: String
  field :unique_id,               type: String
  field :youtube_categories,      type: Array, default: []
  field :youtube_rating_average,  type: Float
  field :youtube_rating_count,    type: Integer
  field :youtube_rating_dislikes, type: Integer
  field :youtube_rating_likes,    type: Integer
  field :youtube_video_id,        type: String
  field :youtube_view_count,      type: Integer

  validates :unique_id, uniqueness: true

  acts_as_url :title, url_attribute: :slug

  search_in :title, :description

  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
  scope :not_approved, -> { where("active IS NULL") }

  def thumbnail
    "http://i.ytimg.com/vi/#{self.unique_id}/hqdefault.jpg"
  end

  def to_keywords
    self.youtube_categories
  end

  def to_s
    self.title
  end

  def to_param
    slug
  end

end
