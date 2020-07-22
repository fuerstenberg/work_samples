FactoryGirl.define do
  factory :conversation do
    memberships { [FactoryGirl.build(:conversation_membership_homer), FactoryGirl.build(:conversation_membership_marge)] }
  end
end
