FactoryBot.define do
  factory :screen do
    customer { Current.customer || create(:customer) }

    name {"Any screen"}
    address { build :address }
  end
end
