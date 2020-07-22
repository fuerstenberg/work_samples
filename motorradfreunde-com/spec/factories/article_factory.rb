FactoryGirl.define do
  factory :article do
    user
    sequence(:title)            {|n| "Artikel #{n}" }
    body  'hier sollten eigentliche lustige Zitate aus Simpsons stehen'
  end
end
