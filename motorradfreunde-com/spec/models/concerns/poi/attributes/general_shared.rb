shared_examples "a general poi" do
  context 'general' do
  end

  context 'concerns' do
  end

  context 'associations' do
  end

  context 'fields' do
    it { is_expected.to have_field(:contact          ).of_type(String  ) }
    it { is_expected.to have_field(:description      ).of_type(String  ) }
    it { is_expected.to have_field(:email            ).of_type(String  ) }
    it { is_expected.to have_field(:enabled_at       ).of_type(DateTime) }
    it { is_expected.to have_field(:enabled_until    ).of_type(DateTime) }
    it { is_expected.to have_field(:fax              ).of_type(String  ) }
    it { is_expected.to have_field(:import_url       ).of_type(String  ) }
    it { is_expected.to have_field(:mobile           ).of_type(String  ) }
    it { is_expected.to have_field(:name             ).of_type(String  ) }
    it { is_expected.to have_field(:opening_times    ).of_type(String  ) }
    it { is_expected.to have_field(:phone            ).of_type(String  ) }
    it { is_expected.to have_field(:premium          ).of_type(Mongoid::Boolean ).with_default_value_of(false) }
    it { is_expected.to have_field(:published        ).of_type(Mongoid::Boolean ).with_default_value_of(false) }
    it { is_expected.to have_field(:types            ).of_type(Array   ).with_default_value_of([]) }
    it { is_expected.to have_field(:website          ).of_type(String  ) }
  end

  context 'validations' do
  end

  context 'class methods' do
  end

  context 'instance methods' do
  end
end
