# Read about factories at http://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  factory :comment do
    association :user, factory: :user
    body "MyText"

    factory :comment_on_bike do
      association :commentable, factory: :bike
    end
  end
end
