class AddressSerializer < BaseSerializer

  attributes :coordinates,
    :street,
    :zip,
    :city,
    :region,
    :state,
    :country,
    :country_code,
    :floor

  def coordinates
    object.to_coordinates
  end

end
