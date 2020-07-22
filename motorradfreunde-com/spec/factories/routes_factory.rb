# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :route do
    user
    name "MyString"
    start_address "MyString"
    end_address "MyString"
    distance 1
    waypoints []
  end
end
