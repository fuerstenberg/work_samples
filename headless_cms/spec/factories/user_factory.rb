FactoryBot.define do

  factory :user do
    name {"Homer Simpson"}
    password               {"topsecret"}
    password_confirmation  {"topsecret"}
    email
    language {"de"}

    trait :admin do
      after(:create) do |user|
        # unless Current.customer?
        #   Current.customer = create :customer
        # end
        user.becomes_admin!
      end
    end

    trait :editor do
      after(:create) do |user|
        unless Current.customer?
          Current.customer = create :customer
        end
        user.becomes_editor_of!(customer: Current.customer)
      end
    end

    trait :god do
      after(:create) do |user|
        user.becomes_god!
      end
    end
  end

end
