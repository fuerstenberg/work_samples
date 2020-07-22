class User

  extend Enumerize

  include Mongoid::Document
  include Mongoid::Search
  include Mongoid::Timestamps

  include Concerns::HasDefaultScopes

  include Amistad::FriendModel

  include Concerns::EmbedsOneAddress
  include Concerns::EmbedsManyComments
  include Concerns::EmbedsManyImages
  include Concerns::HasImpressions
  include Concerns::HasMetaMethods
  include Concerns::HasManyPosts
  include Concerns::HasManyActivities
  include Concerns::User::Conversations
  include Concerns::User::Details
  include Concerns::User::Devise
  include Concerns::User::Facebook
  include Concerns::User::Friends
  include Concerns::User::Greetings
  include Concerns::User::Newsletter
  include Concerns::User::Notifications
  include Concerns::User::Online
  include Concerns::User::PublicActivities
  include Concerns::User::Roles
  include Concerns::User::HasStatistics

  require 'open-uri'

  field :http,               type: String
  field :name,               type: String
  field :newsletter_sent_at, type: DateTime
  field :terms_of_service,   type: Boolean, default: false

  acts_as_url :name, url_attribute: :slug

  search_in :name, address: [:zip, :city, :country]

  has_many :articles,      dependent: :destroy
  has_many :answers,       dependent: :destroy
  has_many :bikes,         dependent: :destroy
  has_many :events,        dependent: :destroy
  has_many :questions,     dependent: :destroy
  has_many :ride_requests, dependent: :nullify
  has_many :routes

  has_many :created_pois, class_name: 'Poi', inverse_of: :creator
  has_many :edited_pois,  class_name: 'Poi', inverse_of: :editor
  has_many :owned_pois,   class_name: 'Poi', inverse_of: :owner

  # has_many :received_messages, dependent: :destroy, class_name: "Message", foreign_key: "receiver_id"
  # has_many :sent_messages,     dependent: :destroy, class_name: "Message", foreign_key: "sender_id"

  scope :by_name,    ->(name){ where("name LIKE ?", "%#{name}%") }
  scope :commercial, ->{ where(commercial: true) }
  scope :email,      ->(email){ where(email: email) }
  scope :admin,      ->{ where(admin: true) }

  scope :men_with_photo_and_most_impressions,   ->{ where("users.images_count > 0").where(gender: 'male'  ).order(:users.impressions_count => :desc) }
  scope :women_with_photo_and_most_impressions, ->{ where("users.images_count > 0").where(gender: 'female').order(:users.impressions_count => :desc) }

  # TODO: acts_as_voter
  # TODO: acts_as_messageable required: :body, dependent: :destroy, group_messages: true, class_name: "Message"

  before_validation :downcase_email

  validates_acceptance_of :terms_of_service, accept: true

  validates :email,            presence: true, uniqueness: true, email: true
  validates :name,             presence: true
  validates :terms_of_service, presence: true


  def self.with_photo_and_most_impressions(limit = 30)
    # TODO: with_photo_and_most_impressions
    # users = self.men_with_photo_and_most_impressions.limit(limit/2) + self.women_with_photo_and_most_impressions.limit(limit/2).reverse
    # result = []
    # while users.count > 0 do
    #   result << users.shift
    #   result << users.pop
    # end
    # result.compact
    limit( limit )
  end

  def new?
    created_at + 2.weeks > Date.today
  end

  def owns?(object)
    object.user == self
  end

  def to_s
    self.name || 'unknown'
  end

  def to_param
    slug
  end

  def to_description
    self.description
  end

  def to_title
    self.to_s
  end

  def to_keywords
    [
      self.to_title,
      self.to_subtitle,
      self.to_description
    ].flatten.map(&:to_s).join(" ").gsub(",", " ").squish.gsub(" ", ", ")
  end

  def to_subtitle
    self.formatted_address
  end

  def to_preview
    self.avatar_image
  end

  def object_type
    self.class.to_s
  end

  def similar_users
    users = User.near_by(self, 20)
    if users.count > 10 and self.date_of_birth and self.age > 18
      year_distance = 8
      users = users.where(date_of_birth: ([self.date_of_birth - year_distance.years, 18].minmax.second..self.date_of_birth + year_distance.years))
    end
    (users - [self]).flatten(2)
  end

  private

  # before_validation
  def downcase_email
    self.email.downcase! if self.email.present?
  end

end
