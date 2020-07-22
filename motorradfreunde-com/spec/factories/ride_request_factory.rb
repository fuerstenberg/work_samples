# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ride_request do
    user
    start_at { Time.now + 2.hours }
  end
end
