shared_examples "a tour operator" do
  context 'general' do
  end

  context 'concerns' do
  end

  context 'associations' do
  end

  context 'fields' do
    it { is_expected.to have_field(:is_tour_operator          ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:reiseanbieter_beschreibung).of_type(String).with_default_value_of('') }
    it { is_expected.to have_field(:reiseanbieter_touren      ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:reiseanbieter_reisen      ).of_type(Mongoid::Boolean).with_default_value_of(false) }
  end

  context 'validations' do
  end

  context 'class methods' do
  end

  context 'instance methods' do
  end
end
