FactoryBot.define do
  factory :content_tree do
    name { "content tree #{rand 99999999}" }
    customer { Current.customer || create(:customer) }

    trait :with_leafs do
      after(:build) do |content_tree|
        build_list :content_leaf, 4, parent: content_tree
      end

      after(:create) do |content_tree|
        create_list :content_leaf, 4, parent: content_tree
      end
    end

    trait :with_pages do
      after(:build) do |content_tree|
        build_list :content_page, 4, :with_leafs, parent: content_tree
      end

      after(:create) do |content_tree|
        create_list :content_page, 4, :with_leafs, parent: content_tree
      end
    end
  end
end
