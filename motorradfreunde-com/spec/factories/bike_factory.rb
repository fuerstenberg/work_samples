FactoryGirl.define do
  factory :bike do
    association :vendor, factory: :vendor
    model                 "K 1200 R"
    ccm                   1200
    hp                    163
    year_of_manufacture   Date.parse("2008-6-1")
    color                 "schwarz"
    description           "Ey caramba"
    user
    # after(:create) do |bike|
    #   bike.photos << FactoryGirl.create(:photo)
    # end

    factory :bike_with_comments do
      after(:create) do |bike, evaluator|
        create_list :comment, 5, commentable: bike
      end
    end

    factory :random_bike do
      model { ['K 1200 R', 'S 1000 RR', 'R 1200 GS', 'F 800', 'K 1300 R', 'RnineT'].sample }
      ccm   { [600, 1000, 1200, 1300].sample }
      hp    { [50,  163, 173, 192].sample }
      color { %w(schwarz rot grau orange gelb grün).sample }
    end
  end

  factory :bmw_k, :parent => :bike do
  end

  factory :bmw_r, :parent => :bike do
    model       "R 1200 GS"
    ccm         1200
    hp          112
  end

  factory :bmw_s, :parent => :bike do
    model       "S 1000 RR"
    ccm         1000
    hp          193
  end

  trait :images do
    images { 3.times.collect{ FactoryGirl.build(:image) } } # create_list does not work here
  end
end
