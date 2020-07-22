FactoryGirl.define do
  factory :notification do
    notification_type "MyString"
    subject_id 1
    subject_type "MyString"
    user_id 1
  end
end
