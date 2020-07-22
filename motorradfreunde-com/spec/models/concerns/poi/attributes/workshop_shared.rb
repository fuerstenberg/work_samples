shared_examples "a workshop" do
  context 'general' do
  end

  context 'concerns' do
  end

  context 'associations' do
  end

  context 'fields' do
    it { is_expected.to have_field(:is_workshop                    ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:werkstatt_beschreibung         ).of_type(String).with_default_value_of('') }
    it { is_expected.to have_field(:werkstatt_austauschmotorraeder ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:werkstatt_ist_typenoffen       ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:werkstatt_marken               ).of_type(String).with_default_value_of('') }
    it { is_expected.to have_field(:werkstatt_hol_bring    ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:werkstatt_hu           ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:werkstatt_inspektionen ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:werkstatt_pannenservice).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:werkstatt_reifen       ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:werkstatt_reparatur    ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:werkstatt_stellplaetze  ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:werkstatt_tuev         ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:werkstatt_umbauten     ).of_type(Mongoid::Boolean).with_default_value_of(false) }
  end

  context 'validations' do
  end

  context 'class methods' do
  end

  context 'instance methods' do
  end
end
