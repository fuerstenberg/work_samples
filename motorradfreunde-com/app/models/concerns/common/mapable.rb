# module Concerns::Common::Mapable
#
#   extend ActiveSupport::Concern
#
#   included do
#     include Geocoder::Model::Mongoid
#
#     field :coordinates, type: Array
#
#     # TODO:
#     # store :address, accessors: [
#     #   :city,
#     #   :country,
#     #   :country_code,
#     #   :formatted_address,
#     #   :full_address,
#     #   :postal_code,
#     #   :precision,
#     #   :province,
#     #   :province_code,
#     #   :route,
#     #   :state,
#     #   :state_code,
#     #   :street_address,
#     #   :street_number,
#     #   :sub_state,
#     #   :sub_state_code
#     # ], coder: JSON
#
#     attr_accessor :server_side_geocoding
#
#     after_initialize do
#       self.server_side_geocoding = true unless self.server_side_geocoding == false
#     end
#
#     geocoded_by :geocodeable_address do |obj, results|
#       if geo = results.first # and [:latitude, :longitude].all?{|m| self.respond_to?(m)}
#         obj.latitude  = geo.latitude
#         obj.longitude = geo.longitude
#       end
#     end
#
#     reverse_geocoded_by :coordinates do |obj, results|
#       if result = results.first
#         obj.address[:city]              = result.city
#         obj.address[:country]           = result.country
#         obj.address[:country_code]      = result.country_code
#         obj.address[:formatted_address] = result.formatted_address
#         obj.address[:latitude]          = result.latitude
#         obj.address[:longitude]         = result.longitude
#         obj.address[:postal_code]       = result.postal_code
#         obj.address[:precision]         = result.precision
#         obj.address[:province]          = result.province
#         obj.address[:province_code]     = result.province_code
#         obj.address[:route]             = result.route
#         obj.address[:state]             = result.state
#         obj.address[:state_code]        = result.state_code
#         obj.address[:street_address]    = result.street_address
#         obj.address[:street_number]     = result.street_number
#         obj.address[:sub_state]         = result.sub_state
#         obj.address[:sub_state_code]    = result.sub_state_code
#       end
#     end
#
#     before_validation :geocode,         if: :mapable_address_changed?
#     before_validation :reverse_geocode, if: :mapable_latitude_or_longitude_changed?
#   end
#
#   module ClassMethods
#
#     def in_bounds(bounds, options = {})
#       bounds = bounds.split(",").map(&:squish).map(&:to_f)
#       crosses_meridian = bounds[0] > bounds[2]
#       lng_sql = crosses_meridian ? "(longitude<#{bounds[3]} OR longitude>#{bounds[1]})" : "longitude>#{bounds[1]} AND longitude<#{bounds[3]}"
#       sql = "latitude>#{bounds[0]} AND latitude<#{bounds[2]} AND #{lng_sql}"
#       where(sql)
#     end
#
#   end
#
#   def geocodeable_address
#     return self.full_address if self.full_address.present? # maybe the address that a user filled into an form
#     return [self.street_address_and_street_number, self.postal_code_and_city, self.state, self.country].select(&:present?).join(", ")
#     nil
#   end
#
#   def complete_address
#     [
#       (self.street_address_and_street_number || self.route),
#       self.postal_code_and_city_and_state_and_country
#     ].select(&:present?).join(", ")
#   end
#
#   def postal_code_and_city_and_state_and_country
#     [
#       self.postal_code_and_city,
#       ((self.state == self.city) ? nil : self.state),
#       self.country
#     ].select(&:present?).join(", ")
#   end
#
#   def street_address_and_street_number
#     if self.street_address.present?
#       return [self.street_address, self.street_number].compact.join(" ")
#     end
#     nil
#   end
#
#   def postal_code_and_city
#     if self.city.present?
#       return [self.postal_code, self.city].compact.join(" ")
#     end
#     nil
#   end
#
#   def geocoded?
#     return false unless latitude.present?
#     return false unless longitude.present?
#     true
#   end
#
#   def mapable_address_changed?
#     return false if self.mapable_latitude_or_longitude_changed?
#     self.server_side_geocoding and self.respond_to?(:address_changed?) and self.address_changed?
#   end
#
#   def mapable_latitude_or_longitude_changed?
#     return false if self.is_a?(PublicActivity::Activity)
#     return false unless self.server_side_geocoding
#     self.latitude_changed? or self.longitude_changed?
#   end
#
#   # <Geocoder::Result::Freegeoip:0x007f2187a64438 @data={
#   #   "ip"=>"84.135.124.144",
#   #   "country_code"=>"DE",
#   #   "country_name"=>"Germany",
#   #   "region_code"=>"16",
#   #   "region_name"=>"Berlin",
#   #   "city"=>"Berlin",
#   #   "zipcode"=>"",
#   #   "latitude"=>52.5167,
#   #   "longitude"=>13.4,
#   #   "metro_code"=>"",
#   #   "area_code"=>""}, @cache_hit=nil>
#   def update_from_request(request)
#     if request.location and !self.geocoded?
#       self.latitude      = request.location.data["latitude"]
#       self.longitude     = request.location.data["longitude"]
#       self.city          = request.location.data["city"]
#       self.state         = request.location.data["region_name"]
#       self.postal_code   = request.location.data["zip_code"]
#       self.country       = request.location.data["country_name"]
#       self.country_code  = request.location.data["country_code"]
#       self.save validate: false
#     end
#   rescue
#     nil
#   end
#
# end
