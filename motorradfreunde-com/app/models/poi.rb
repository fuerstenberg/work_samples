class Poi

  extend Enumerize

  include Mongoid::Document
  include Mongoid::History::Trackable
  include Mongoid::Search
  include Mongoid::Timestamps

  include Concerns::HasDefaultScopes

  include Concerns::EmbedsManyFeeds
  include Concerns::EmbedsManyImages
  include Concerns::EmbedsOneAddress
  include Concerns::HasImpressions
  include Concerns::HasManyActivities
  include Concerns::HasManyPosts
  include Concerns::HasMetaMethods
  include Concerns::IsAdminReporter

  include Concerns::Poi::Attributes::MetaInspector
  include Concerns::Poi::Attributes::General
  include Concerns::Poi::Attributes::BikeBuilder
  include Concerns::Poi::Attributes::Dealer
  include Concerns::Poi::Attributes::Hotel
  include Concerns::Poi::Attributes::Magazin
  include Concerns::Poi::Attributes::MountainPass
  include Concerns::Poi::Attributes::RentalCompany
  include Concerns::Poi::Attributes::Shop
  include Concerns::Poi::Attributes::TourOperator
  include Concerns::Poi::Attributes::Vendor
  include Concerns::Poi::Attributes::Workshop

  has_many :routes, dependent: :destroy, as: :routable

  belongs_to :creator, class_name: 'User', inverse_of: :created_pois
  belongs_to :editor,  class_name: 'User', inverse_of: :edited_pois
  belongs_to :owner,   class_name: 'User', inverse_of: :owned_pois

  # field :bike_manufacturer,    type: Boolean, default: false
  field :tags, type: Array, default: []

  validates :name, presence: true

  acts_as_url :name, url_attribute: :slug

  search_in :name, :description, :http, :types, address: [:zip, :city, :country, :street]

  track_history on: [:fields]

  scope :active,             ->{ where("enabled_until >= ?", Date.today) }
  scope :bike_manufacturer,  ->{ where(bike_manufacturer: true) }
  scope :has_no_link,        ->{ where("http is null or http = ''") }
  scope :has_no_description, ->{ where("description is null or description = ''") }
  scope :inactive,           ->{ where("enabled_until < ?",  Date.today) }
  scope :premium,            ->{ where(premium: true) }

  def self.ads(addressable = nil, options = {})
    options.reverse_merge!({
      limit: 3
    })
    if addressable and addressable.is_a?(Poi) and addressable.premium?
      return []
    end
    pois = []
    if addressable and addressable.address.geocoded?
      pois += premium.near_by(addressable, 50).to_a
      pois += premium.limit(options[:limit]).to_a
      pois += near_by(addressable, 50).to_a
    end
    pois.uniq[0...options[:limit]] - [addressable]
  end

  def enabled?
    Date.today.between?(self.enabled_at, self.enabled_until)
  rescue
    false
  end

  def is
    attributes.select do |attribute, value|
      attribute.to_s.starts_with?('is_') and value == true
    end.map do |attribute, value|
      I18n.t "activerecord.attributes.poi.#{attribute}"
    end.sort.join(', ')
  rescue
    ""
  end

  def has
    attributes.select do |attribute, value|
      attribute.to_s.starts_with?('has_') and value == true
    end.map do |attribute, value|
      I18n.t "activerecord.attributes.poi.#{attribute}"
    end.sort.join(', ')
  end

  def object_type
    self.class.to_s
  end

  def to_param
    slug
  end

  def to_title
    self.to_s
  end

  def to_subtitle
    formatted_address
  end

  def to_keywords
    [self.name, self.is].join(',')
  end

  def to_description
    self.description[0,155] rescue ""
  end

  def to_s
    self.name
  end

end
