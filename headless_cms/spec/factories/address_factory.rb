FactoryBot.define do

  factory :address do
    city         {"Eisenach"}
    country      {"Deutschland"}
    country_code {"DE"}
    floor        {"1"}
    region       {"Hainich"}
    state        {"Thüringen"}
    street       {"Wernickstraße 22"}
    zip          {"99817"}
    coordinates  {[52.123456, 13.123456]}
  end

end
