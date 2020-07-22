class Poi
  include Mongoid::Document

  # store_in collection: 'pois'

  field :_old_address, type: String
  field :latitude,  type: Float
  field :longitude, type: Float

  embeds_one :address, as: :addressable
end

class PoiAddressImporter

  def initialize
    Poi.all.each do |poi|
      puts poi._old_address

      if poi._old_address
        old_address = JSON.parse poi._old_address
        coordinates = [poi.longitude, poi.latitude].compact
        poi.build_address unless poi.address
        poi.address.coordinates  = (coordinates.size == 2 ? coordinates : [])
        poi.address.city         = old_address['city']
        poi.address.country      = old_address['country']
        poi.address.country_code = old_address['country_code']
        poi.address.state        = old_address['state']
        poi.address.street       = [ old_address['street_address'], old_address['street_number'] ].join(" ")
        poi.address.zip          = old_address['postal_code']
        poi.address.save
      end
    end
  end

end
