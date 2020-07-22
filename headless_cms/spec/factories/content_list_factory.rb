FactoryBot.define do
  factory :content_list do
    name { "content list #{rand 99999999}" }
    customer { Current.customer || create(:customer) }

    trait :with_leafs do
      after(:build) do |content_list|
        build_list :content_leaf, 4, parent: content_list
      end

      after(:create) do |content_list|
        create_list :content_leaf, 4, parent: content_list
      end
    end
  end
end
