Geocoder.configure(:lookup => :test)

# Geocoder::Lookup::Test.add_stub(
#   "New York, NY", [
#     {
#       'latitude'     => 40.7143528,
#       'longitude'    => -74.0059731,
#       'address'      => 'New York, NY, USA',
#       'state'        => 'New York',
#       'state_code'   => 'NY',
#       'country'      => 'United States',
#       'country_code' => 'US'
#     }
#   ]
# )
#
Geocoder::Lookup::Test.set_default_stub(
  [
    {
      'latitude'     => 52.123456,
      'longitude'    => 13.123456,
      'address'      => '99817 Eisenach, Wernickstraße 22',
      'state'        => 'Thüringen',
      'state_code'   => 'Th',
      'country'      => 'Deutschland',
      'country_code' => 'DE'
    }
  ]
)
