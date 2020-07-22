class Address

  include Mongoid::Document
  include Mongoid::Timestamps
  include Geocoder::Model::Mongoid

  embedded_in :addressable, polymorphic: true

  field :city,                type: String, default: ""
  field :coordinates,         type: Array,  default: []
  field :country,             type: String, default: ""
  field :country_code,        type: String, default: ""
  field :data,                type: Hash,   default: {}
  field :floor,               type: String, default: ""
  field :region,              type: String, default: ""
  field :state,               type: String, default: ""
  field :state_code,          type: String, default: ""
  field :street,              type: String, default: ""
  field :street_number,       type: String, default: ""
  field :sublocality_level_1, type: String, default: ""
  field :zip,                 type: String, default: ""

  alias_method :postal_code,  :zip
  alias_method :postal_code=, :zip=

  attr :latitude
  attr :longitude

  validates :city, presence: { if: ->{ self.street.present? or self.zip.present? } }
  validates :zip,  presence: { if: ->{ self.street.present? or self.city.present? } }

  mount_uploader :static_map, StaticMapUploader

  geocoded_by :address_for_geocoder
  reverse_geocoded_by :coordinates

  after_validation :geocode_if_needed
  after_validation :reverse_geocode_if_needed
  before_save :refresh_static_map

  def download_static_map
    self.remote_static_map_url = self.static_map_url
  end

  def latitude=(value)
    if value.present?
      coordinates[1] = value.to_f
    end
  end

  def longitude=(value)
    if value.present?
      coordinates[0] = value.to_f
    end
  end

  def preview(format)
    static_map.url format
  end

  def refresh_static_map(force = false)
    if force or (self.geocoded? and self.changed?)
      download_static_map
    end
  end

  def static_map_url
    url = [
      "https://maps.googleapis.com/maps/api/staticmap",
      "?sensor=false",
      "&size=640x640",
      "&key=#{Rails.application.secrets.google_static_map_key}"
    ]
    if self.addressable.is_a?(Route)
      url << "&path="
      url << ERB::Util.url_encode("weight:3|color:blue|enc:#{self.addressable.static_polyline}")
    else
      url << "&zoom=10"
      url << "&markers="
      url << ERB::Util.url_encode("color:red|#{self.to_coordinates[0]},#{self.to_coordinates[1]}")
    end
    url.join
  end

  # returns the address as a comma separated string
  #   My street 1, 12345 Berlin, Deutschland
  def to_s
    [
      self.street,
      self.zip_and_city,
      self.country
    ].select(&:present?).join(", ")
  end

  def zip_and_city
    [self.zip, self.city].join(" ").squish
  end

  private

  def address_fields_changed?
    [
      city_changed?,
      country_changed?,
      region_changed?,
      state_changed?,
      street_changed?,
      zip_changed?,
    ].any?
  end

  def address_for_geocoder
    [
      zip_and_city,
      street.squish
    ].select(&:present?).uniq.join(', ')
  end

  def geocode_if_needed
    if address_fields_changed? and not coordinates_changed?
      geocode
    end

    # if !self.geocoded? and result = Geocoder.search( self.zip_and_city ).first
    #   logger.info "Geocoder#search: #{self.zip_and_city}"
    #   self.coordinates = [result.longitude, result.latitude] # MongoID order
    # end
  end

  def reverse_geocode_if_needed
    if coordinates_changed? and not address_fields_changed? and result = Geocoder.search( self.to_coordinates ).first
      self.data                  = result.data
      self.city                  = result.city
      self.sublocality_level_1   = result.address_components_of_type(:sublocality_level_1)&.first&.fetch('long_name') # Bezirk Pankow
      self.state                 = result.state
      self.state_code            = result.state_code
      self.country               = result.country
      self.country_code          = result.country_code
      self.street                = result.route
      self.street_number         = result.street_number
      self.postal_code           = result.postal_code
    end
  end

end
