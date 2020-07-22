# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ad do
    customer
    title       "Google Ad"
    target      "sidebar"
    html        "some html ad code"
    javascript  "some javascript ad code"
    url         "http://www.any-ad-url.com"
    description "any ad description"
  end
end
