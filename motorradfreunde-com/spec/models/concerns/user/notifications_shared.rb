shared_examples "an object which has notifications" do
  context 'general' do
  end

  context 'concerns' do
  end

  context 'associations' do
    it { is_expected.to have_many(:notifications           ).with_dependent(:destroy) }
    it { is_expected.to have_many(:notifications_as_subject).with_dependent(:destroy).of_type(Notification) }
  end

  context 'fields' do
  end

  context 'validations' do
  end

  context 'class methods' do
  end

  context 'instance methods' do
  end
end
