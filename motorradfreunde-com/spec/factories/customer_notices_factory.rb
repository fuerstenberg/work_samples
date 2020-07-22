# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer_notice do
    customer_id 1
    body "MyText"
  end
end
