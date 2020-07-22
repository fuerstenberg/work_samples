FactoryBot.define do
  factory :content_page do
    name { "content page #{rand 99999999}" }
    parent { create :content_tree }

    trait :with_pages do
      after(:build) do |content_page|
        build_list :content_page, 4, parent: content_page
      end

      after(:create) do |content_page|
        create_list :content_page, 4, parent: content_page
      end
    end

    trait :with_leafs do
      after(:build) do |content_page|
        build_list :content_leaf, 4, parent: content_page
      end

      after(:create) do |content_page|
        create_list :content_leaf, 4, parent: content_page
      end
    end
  end
end
