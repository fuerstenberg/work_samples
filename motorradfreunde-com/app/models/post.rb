class Post

  include Mongoid::Document
  include Mongoid::Search
  include Mongoid::Timestamps

  include Concerns::EmbedsManyImages
  include Concerns::HasImpressions
  include Concerns::HasManyActivities
  include Concerns::IsFeedItem

  belongs_to :poster, polymorphic: true

  acts_as_url :title, url_attribute: :slug

  def to_param
    slug || id.to_s
  end

  def to_s
    title
  end

end
