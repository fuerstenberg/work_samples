describe Article do
  context 'general' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to be_timestamped_document }
  end

  context 'concerns' do
  end

  context 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  context 'fields' do
    it { is_expected.to have_field(:active   ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:body     ).of_type(String) }
    it { is_expected.to have_field(:body_html).of_type(String) }
    it { is_expected.to have_field(:http     ).of_type(String) }
    it { is_expected.to have_field(:news     ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:source   ).of_type(String) }
  end

  context 'validations' do
  end

  context 'class methods' do
  end

  context 'instance methods' do
  end
end
