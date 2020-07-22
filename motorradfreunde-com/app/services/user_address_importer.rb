class MyUser
  include Mongoid::Document

  store_in collection: 'users'

  field :_old_address, type: String
  field :latitude,  type: Float
  field :longitude, type: Float

  embeds_one :address, as: :addressable
end

class UserAddressImporter

  def initialize
    MyUser.all.each do |user|
      puts user._old_address

      if user._old_address
        old_address = JSON.parse user._old_address
        coordinates = [user.longitude, user.latitude].compact
        user.build_address unless user.address
        user.address.coordinates  = (coordinates.size == 2 ? coordinates : [])
        user.address.city         = old_address['city']
        user.address.country      = old_address['country']
        user.address.country_code = old_address['country_code']
        user.address.state        = old_address['state']
        user.address.street       = [ old_address['street_address'], old_address['street_number'] ].join(" ")
        user.address.zip          = old_address['postal_code']
        user.address.save
      end
    end
  end

end
