describe Address do
  context 'general' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to be_timestamped_document }
  end

  context 'concerns' do
    it 'should be sortable'
  end

  context 'associations' do
    it { is_expected.to be_embedded_in(:addressable).with_polymorphism }
  end

  context 'fields' do
    it { is_expected.to have_field(:city        ).of_type(String).with_default_value_of("") }
    it { is_expected.to have_field(:coordinates ).of_type(Array ).with_default_value_of([]) }
    it { is_expected.to have_field(:country     ).of_type(String).with_default_value_of("") }
    it { is_expected.to have_field(:country_code).of_type(String).with_default_value_of("") }
    it { is_expected.to have_field(:floor       ).of_type(String).with_default_value_of("") }
    it { is_expected.to have_field(:region      ).of_type(String).with_default_value_of("") }
    it { is_expected.to have_field(:state       ).of_type(String).with_default_value_of("") }
    it { is_expected.to have_field(:street      ).of_type(String).with_default_value_of("") }
    it { is_expected.to have_field(:zip         ).of_type(String).with_default_value_of("") }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:zip) }
  end

  context 'class methods' do
  end

  context 'instance methods' do
    it 'address_for_geocoder'
    it 'download_static_map'
    it 'geocode_fallback'
    it 'static_map_url'
    it 'to_s'
  end
end
