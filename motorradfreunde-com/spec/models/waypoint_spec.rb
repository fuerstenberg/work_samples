describe Waypoint do
  context 'general' do
    it { is_expected.to be_mongoid_document }
  end

  context 'concerns' do
  end

  context 'associations' do
    it { is_expected.to be_embedded_in(:route) }
  end

  context 'fields' do
    it { is_expected.to have_field(:latitude ).of_type(Float) }
    it { is_expected.to have_field(:longitude).of_type(Float) }
    it { is_expected.to have_field(:elevation).of_type(Integer) }
  end

  context 'validations' do
  end

  context 'class methods' do
  end

  context 'instance methods' do
  end
end
