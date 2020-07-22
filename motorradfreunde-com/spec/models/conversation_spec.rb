describe Conversation do
  context 'general' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to be_timestamped_document }
  end

  context 'concerns' do
  end

  context 'associations' do
    it { is_expected.to embed_many(:memberships) }
    it { is_expected.to have_many(:messages).ordered_by(:created_at.desc) }
  end

  context 'fields' do
    it { is_expected.to have_field(:name       ).of_type(String) }
    it { is_expected.to have_field(:description).of_type(String) }
  end

  context 'validations' do
  end

  context 'class methods' do
    it 'should find all conversations by member' do
      conversation = create :conversation
      conversation.memberships.each do |membership|
        expect(membership.conversation).to eq conversation
      end
    end

    it 'should initialize conversation by members with find_or_initialize_by_members' do
      homer = create :homer
      marge = create :marge
      conversation = described_class.find_or_initialize_by_members homer, marge
      expect(conversation).to be_new_record
      expect(conversation.members).to include homer
      expect(conversation.members).to include marge
    end

    it 'should find existing conversation by members with find_or_initialize_by_members' do
      conversation = create :conversation
      conversation_a = described_class.find_or_initialize_by_members conversation.memberships[0].user, conversation.memberships[1].user
      conversation_b = described_class.find_or_initialize_by_members conversation.memberships[1].user, conversation.memberships[0].user
      expect(conversation).to_not be_new_record
      expect(conversation_a).to eq conversation_b
      conversation.memberships.each do |membership|
        expect(membership.conversation).to eq conversation
      end
    end

    it 'should find existing conversation by members with find_or_create_by_members' do
      conversation = create :conversation
      conversation_a = described_class.find_or_create_by_members conversation.memberships[0].user, conversation.memberships[1].user
      conversation_b = described_class.find_or_create_by_members conversation.memberships[1].user, conversation.memberships[0].user
      expect(conversation).to_not be_new_record
      expect(conversation_a).to eq conversation_b
      conversation.memberships.each do |membership|
        expect(membership.conversation).to eq conversation
      end
    end

    it 'should create conversation by members with find_or_create_by_members' do
      homer = create :homer
      marge = create :marge
      conversation = described_class.find_or_create_by_members homer, marge
      expect(conversation).to_not be_new_record
      expect(homer.reload.conversations).to include conversation
      expect(marge.reload.conversations).to include conversation
    end
  end

  context 'instance methods' do
  end
end
