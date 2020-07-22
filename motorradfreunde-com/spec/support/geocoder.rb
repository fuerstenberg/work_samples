addresses = {
  "22003 Springfield, Evergreen" => {
      'latitude' => 40.7573862,
      'longitude' => -73.9881256,
      'address' => '230 West 43rd St., New York City, NY 10036',
      'city' => 'New York City',
      'state' => 'New York',
      'state_code' => 'NY',
      'country' => 'United States',
      'country_code' => 'US'
  },
  "230 West 43rd St., New York City, NY 10036" => {
      'latitude' => 40.7573862,
      'longitude' => -73.9881256,
      'address' => '230 West 43rd St., New York City, NY 10036',
      'city' => 'New York City',
      'state' => 'New York',
      'state_code' => 'NY',
      'country' => 'United States',
      'country_code' => 'US'
  },
  [40.75747130000001, -73.9877319] => {
      'latitude' => 40.75747130000001,
      'longitude' => -73.9877319,
      'address' => '229 West 43rd St., New York City, NY 10036',
      'city' => 'New York City',
      'state' => 'New York',
      'state_code' => 'NY',
      'country' => 'United States',
      'country_code' => 'US'
  },
  "Worthington, OH" => {
    'latitude' => 40.09846115112305,
    'longitude' => -83.01747131347656,
    'address' => 'Worthington, OH',
    'city' => 'Worthington',
    'state' => 'Ohio',
    'state_code' => 'OH',
    'country' => 'United States',
    'country_code' => 'US'
  },
  "99817 Eisenach, Wernickstraße 22" => {
    'latitude' => 40.09846115112305,
    'longitude' => -83.01747131347656,
    'address' => 'Wernickstraße 22, 99817 Eisenach, Germany',
    'city' => 'Eisenach',
    'state' => 'Thüringen',
    'state_code' => 'TH',
    'country' => 'Germany',
    'country_code' => 'DE'
  },
}

Geocoder.configure(lookup: :test)
addresses.each { |lookup, results| Geocoder::Lookup::Test.add_stub(lookup, [results]) }
