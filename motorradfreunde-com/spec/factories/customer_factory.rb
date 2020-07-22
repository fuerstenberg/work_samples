FactoryGirl.define do

  factory :customer do
    name            "Berghotel GmbH"
    contact         "Bernhard Beinhart"
    email
    street          "Berghotelstrasse 1"
    city            "Alpenberg"
    zip             "12345"
    country         "DE"
    phone           "01234 567890"
    fax             "01234 567890"
    description     "Rechnung bitte per Fax senden."
    url
  end

end
