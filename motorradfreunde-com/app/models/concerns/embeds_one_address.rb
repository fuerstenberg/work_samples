module Concerns::EmbedsOneAddress

  extend ActiveSupport::Concern

  included do
    embeds_one :address, as: :addressable, autobuild: true, cascade_callbacks: true

    accepts_nested_attributes_for :address #, allow_destroy: true #, reject_if: lambda{|o| o["photo"].blank? }

    delegate :geocoded?,      to: :address
    delegate :latitude=,      to: :address
    delegate :longitude=,     to: :address
    delegate :to_coordinates, to: :address

    index({ 'address.coordinates' => '2dsphere' }, { min: -180, max: 180 })

    scope :near_by, ->(coordinates, distance = 100) do
      coordinates = if coordinates.is_a?(Array)
        coordinates
      elsif coordinates.respond_to?(:coordinates)
        coordinates.coordinates
      elsif coordinates.try(:address).try(:coordinates).present?
        coordinates.address.coordinates
      end

      if coordinates.blank?
        none
      else
        where({
          "address.coordinates" => {
            :$near => {
              :$geometry => {
                type: 'Point',
                coordinates: coordinates
              },
              :$maxDistance => (distance * 1000)
            }
          }
        })
      end
    end

    scope :in_bounds, ->(point_1, point_2) do
      coordinates = [point_1, point_2].map do |coordinates|
        if coordinates.is_a?(Array)
          coordinates
        elsif coordinates.respond_to?(:coordinates)
          coordinates.coordinates
        elsif coordinates.respond_to?(:address)
          coordinates.address.coordinates
        end
      end

      where({
        "address.coordinates" => {
          :$geoWithin => {
            :$box => coordinates
          }
        }
      })
    end

  end

  def formatted_address
    if self.kind_of? User
      formatted_address_without_street
    else
      formatted_address_with_street
    end
  end

  def formatted_address_with_street
    [
      formatted_street,
      formatted_zip_city,
      formatted_state,
      formatted_country,
    ].select(&:present?).compact
  end

  def formatted_address_without_street
    [
      formatted_zip_city,
      formatted_state,
      formatted_country,
    ].select(&:present?).compact
  end

  def formatted_country
    address.try(:country)
  end

  def formatted_state
    address.try(:state)
  end

  def formatted_street
    address.try(:street)
  end

  def formatted_zip_city
    [ address.try(:zip), address.try(:city) ].compact.join(' ')
  end

  # <Geocoder::Result::Freegeoip:0x007f2187a64438 @data={
  #   "ip"=>"84.135.124.144",
  #   "country_code"=>"DE",
  #   "country_name"=>"Germany",
  #   "region_code"=>"16",
  #   "region_name"=>"Berlin",
  #   "city"=>"Berlin",
  #   "zipcode"=>"",
  #   "latitude"=>52.5167,
  #   "longitude"=>13.4,
  #   "metro_code"=>"",
  #   "area_code"=>""}, @cache_hit=nil>
  def update_from_request(request)
    if request.location and !self.geocoded?
      self.address.coordinates = [
        request.location.data["longitude"],
        request.location.data["latitude"]
      ]
      self.address.city          = request.location.data["city"]
      self.address.state         = request.location.data["region_name"]
      self.address.zip           = request.location.data["zip_code"]
      self.address.country       = request.location.data["country_name"]
      self.address.country_code  = request.location.data["country_code"]
      self.address.save validate: false
    end
  rescue
    nil
  end

end
