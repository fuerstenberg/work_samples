FactoryGirl.define do
  factory :conversation_membership_homer, class: ConversationMembership do
    association :user, factory: :homer, strategy: :create
  end

  factory :conversation_membership_marge, class: ConversationMembership do
    association :user, factory: :marge, strategy: :create
  end
end
