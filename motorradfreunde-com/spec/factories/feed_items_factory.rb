# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feed_item do
    feed_id 1
    title "MyString"
    url "MyString"
    author "MyString"
    summary "MyText"
    content "MyText"
    published "2013-03-29 12:50:55"
    categories "MyText"
  end
end
