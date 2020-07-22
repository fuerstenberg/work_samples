FactoryGirl.define do
  factory :message do
    body   "Lorem ipsum dolor sit amet"
    sender { create(:homer) }
    opened false
  end
end
