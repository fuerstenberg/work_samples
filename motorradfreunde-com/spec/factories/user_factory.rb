FactoryGirl.define do
  factory :user do
    initialize_with { User.find_or_create_by(name: name)}

    name                   "Homer Simpson"
    password               "secret"
    password_confirmation  "secret"
    gender                 "male"
    terms_of_service       true
    email

    address  { FactoryGirl.build(:address) }

    factory(:homer ){ name "Homer Simpson" }
    factory(:marge ){ name "Marge Simpson" }
    factory(:bart  ){ name "Bart Simpson"  }
    factory(:lisa  ){ name "Lisa Simpson"  }
    factory(:maggy ){ name "Maggy Simpson" }
    factory(:moe   ){ name "Moe Szyslak"   }
    factory(:ned   ){ name "Ned Flanders"  }
    factory(:barney){ name "Barney Gumble" }
    factory(:nelson){ name "Nelson Muntz"  }

    trait :with_address do
      association :address, factory: :address, strategy: :build
    end

    trait :avatar do
      # after(:create) do |user, evaluator|
      #   create :image, imageable: user, user: user, avatar: true
      # end
    end

    trait :bikes do
      after(:create) do |user, evaluator|
        create_list :random_bike, 5, user: user
      end
    end

    trait :cover do
      # after(:create) do |user, evaluator|
      #   create :image, imageable: user, user: user, cover: true
      # end
    end

    trait :details do
      date_of_birth        { Date.today - 30.years }
      description          'Meine Beschreibung von mir'
      distance_per_year    10000
      distance_total       80000
      driving_description  'Ich fahre gern schnell'
      favorite_vendor      'BMW'
      favourite_areas      'Thüringen, Alpen'
      favourite_experience 'My first ride'
      licence_date         { Date.today }

      favorite_clothing         %w(textile leather)
      favorite_drive_type       %w(cardan chain belt)
      favorite_driving_style    %w(cruise offroad race tour fast speeder)
      interested_in_gender      %w(male female)
      status_as_biker           %w(driver passenger)
      status_of_social_behavior %w(alone multiple)

      favorite_engine_amount_of_cylinders 4
      gender                              'male'
      has_own_motorcycle                  'yes'
      status_for_backseat                 'not_looking_for_someone'
      status_for_relationship             'married'
    end

    trait :friends do
      after(:create) do |user, evaluator|
        user.friends << create(:user, name: 'Martin Prince')
        user.friends << create(:user, name: 'Milhouse van Houten')
        user.friends << create(:user, name: 'Nelson Muntz')
        user.friends << create(:user, name: 'Richard')
        user.friends << create(:user, name: 'Sherri und Terri')
      end
    end

    trait :friend do
      after(:create) do |user, evaluator|
        # user.friends << create(:user, name: 'Milhouse van Houten')
        milhouse = create(:user, name: 'Milhouse van Houten')
        user.invite milhouse
        milhouse.approve user
      end
    end

    trait :neighbours do
      after(:create) do |user, evaluator|
        create(:user, name: 'Martin Prince')
        create(:user, name: 'Sherri und Terri')
      end
    end

    trait :images do
      images { 3.times.collect{ FactoryGirl.build(:image) } } # create_list does not work here
    end
  end
end
