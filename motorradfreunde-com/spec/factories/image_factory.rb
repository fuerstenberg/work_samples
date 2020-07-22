FactoryGirl.define do
  factory :image do
    file File.open("spec/support/testbild.png")
    user

    factory :image_on_bike do
      association :imageable, factory: :bike
    end
  end
end
