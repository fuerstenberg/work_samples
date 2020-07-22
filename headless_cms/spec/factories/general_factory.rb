FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :url do |n|
    "http://www.my-url-#{n}.com"
  end
end
