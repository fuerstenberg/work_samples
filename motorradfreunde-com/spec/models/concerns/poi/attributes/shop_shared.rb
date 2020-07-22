shared_examples "a shop" do
  context 'general' do
  end

  context 'concerns' do
  end

  context 'associations' do
  end

  context 'fields' do
    it { is_expected.to have_field(:is_online_shop         ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:is_shop                ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:shop_beschreibung      ).of_type(String).with_default_value_of('') }
    it { is_expected.to have_field(:shop_bekleidung        ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:shop_bekleidung_helme  ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:shop_bekleidung_leder  ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:shop_bekleidung_textil ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:shop_finanzierung      ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:shop_geschenkgutscheine).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:shop_zubehoer          ).of_type(Mongoid::Boolean).with_default_value_of(false) }
  end

  context 'validations' do
  end

  context 'class methods' do
  end

  context 'instance methods' do
  end
end
