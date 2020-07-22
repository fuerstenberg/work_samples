shared_examples "a bike builder" do
  context 'general' do
  end

  context 'concerns' do
  end

  context 'associations' do
  end

  context 'fields' do
    it { is_expected.to have_field(:is_bike_builder           ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:motorradbauer_beschreibung).of_type(String).with_default_value_of('') }
  end

  context 'validations' do
  end

  context 'class methods' do
  end

  context 'instance methods' do
  end
end
