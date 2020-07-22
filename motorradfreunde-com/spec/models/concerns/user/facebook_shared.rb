shared_examples "an object which accepts facebook authentication" do
  context 'general' do
  end

  context 'concerns' do
  end

  context 'associations' do
  end

  context 'fields' do
    it { is_expected.to have_field(:uid             ).of_type(String) }
    it { is_expected.to have_field(:facebook_link   ).of_type(String) }
    it { is_expected.to have_field(:oauth_expires_at).of_type(DateTime) }
    it { is_expected.to have_field(:oauth_token     ).of_type(String) }
    it { is_expected.to have_field(:provider        ).of_type(String) }
  end

  context 'validations' do
  end

  context 'class methods' do
    it 'should test all class methods from facebook concern'
  end

  context 'instance methods' do
    it 'should test all instance methods from facebook concern'
  end
end
