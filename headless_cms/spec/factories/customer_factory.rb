FactoryBot.define do

  factory :customer do
    name {"Apple"}
    address { build :address }

    after(:create) do |customer|
      Current.customer = customer
    end

    trait :with_screens do
      after(:create) do |customer|
        create_list :screen, 2, customer: customer
      end
    end

    trait :with_real_estates do
      after(:build) do |customer|
        customer.real_estates.build attributes_for(:real_estate)
      end

      after(:create) do |customer|
        customer.real_estates.each &:save!
      end
    end

    trait :with_contents do
      after(:build) do |customer|
        customer.contents.build attributes_for(:content)
      end

      after(:create) do |customer|
        customer.contents.each &:save!
      end
    end
  end
end
