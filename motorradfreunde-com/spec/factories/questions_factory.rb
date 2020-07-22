FactoryGirl.define do
  factory :question do
    title "MyString"
    body "MyText"
    highlight false
    user_id 1
    forum
  end
end
