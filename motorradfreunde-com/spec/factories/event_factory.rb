FactoryGirl.define do
  factory :event do
    title           "Tour to Shelbyville"
    start_at        { Date.today + 1.day }
    end_at          { Date.today + 2.days }
    description     "Tour to Shelbyville about 3 hours"
    url             "http://www.event_page.de"
    user

    trait :with_address do
      association :address, factory: :address, strategy: :build
    end

    factory :random_event do
      title {
        [
          ['Motorradtreffen', 'Motorradmesse', 'Motorradausfahrt', ''].sample,
          ['Berlin', 'Hamburg', 'München', 'Köln', 'Erfurt', 'Dresden', 'Leipzig'].sample
        ].join(' ')
      }
      description { "Hier geht richtig was ab..." }
      start_at    { Date.today + 1.day }
      end_at      { Date.today + 2.days }
      # hide_time   { [true, false].sample }
      hide_time   true
    end
  end
end
