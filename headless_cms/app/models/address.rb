class Address

  include Mongoid::Document
  include Mongoid::Timestamps
  include Geocoder::Model::Mongoid

  embedded_in :addressable, polymorphic: true

  field :city,          type: String, default: ""
  field :coordinates,   type: Array,  default: []
  field :country,       type: String, default: ""
  field :country_code,  type: String, default: ""
  field :floor,         type: String, default: ""
  field :region,        type: String, default: ""
  field :state,         type: String, default: ""
  field :street,        type: String, default: ""
  field :zip,           type: String, default: ""

  delegate :customer, to: :addressable, allow_nil: true

  validates :city, presence: { if: ->{ self.street.present? or self.zip.present? } }
  validates :zip,  presence: { if: ->{ self.street.present? or self.city.present? } }

  geocoded_by :address_for_geocoder

  before_save :geocode_fallback

  def address_for_geocoder
    [
      [
        self.zip,
        self.city
      ].join(" ").squish,
      self.street.squish
    ].select(&:present?).uniq.join(', ')
  end

  def geocode_fallback
    if !self.has_location? and result = Geocoder.search( [self.zip, self.city].join(" ") ).first
      self.coordinates = [result.longitude, result.latitude] # MongoID order
    end
  end

  def has_location?
    !self.coordinates.empty? and
    self.coordinates[0] != 0 and
    self.coordinates[1] != 0
  end

  # returns the address as a comma separated string
  #   My street 1, 12345 Berlin, Deutschland
  def to_s
    [
      self.street,
      [
        self.zip,
        self.city
      ].join(" "),
      self.country
    ].select(&:present?).join(", ")
  end

end
