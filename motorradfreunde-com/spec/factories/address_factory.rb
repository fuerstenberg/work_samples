FactoryGirl.define do
  factory :address do
    # floor         ''
    city          'Springfield'
    country       'USA'
    country_code  'US'
    state         'Virginia'
    street        'Evergreen'
    zip           '22003'

    coordinates [-77.1881981, 38.8315437]
  end
end
