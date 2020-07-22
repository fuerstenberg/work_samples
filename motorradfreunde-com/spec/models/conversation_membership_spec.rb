describe ConversationMembership do
  context 'general' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to be_timestamped_document }
  end

  context 'concerns' do
  end

  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to be_embedded_in(:conversation).as_inverse_of(:memberships) }
  end

  context 'fields' do
    it { is_expected.to have_field(:admin  ).of_type(Mongoid::Boolean) }
    it { is_expected.to have_field(:read_at).of_type(Time) }
  end

  context 'validations' do
  end

  context 'class methods' do
  end

  context 'instance methods' do
  end
end
