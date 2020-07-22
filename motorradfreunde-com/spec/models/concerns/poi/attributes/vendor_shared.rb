shared_examples "a vendor" do
  context 'general' do
  end

  context 'concerns' do
  end

  context 'associations' do
    it { is_expected.to have_many(:bikes) }
  end

  context 'fields' do
    it { is_expected.to have_field(:bikes_count            ).of_type(Fixnum).with_default_value_of(0) }
    it { is_expected.to have_field(:hersteller_beschreibung).of_type(String).with_default_value_of('') }
    it { is_expected.to have_field(:is_vendor              ).of_type(Mongoid::Boolean).with_default_value_of(false) }
  end

  context 'validations' do
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  context 'class methods' do
  end

  context 'instance methods' do
  end
end
