shared_examples "is feed item" do |parent|
  context 'general' do
  end

  context 'concerns' do
  end

  context 'associations' do
    it { is_expected.to belong_to(:feed) }
  end

  context 'fields' do
    it { is_expected.to have_field(:active      ).of_type(Mongoid::Boolean).with_default_value_of(true) }
    it { is_expected.to have_field(:author      ).of_type(String) }
    it { is_expected.to have_field(:categories  ).of_type(String) }
    it { is_expected.to have_field(:content     ).of_type(String) }
    it { is_expected.to have_field(:description ).of_type(String) }
    it { is_expected.to have_field(:guid        ).of_type(String) }
    it { is_expected.to have_field(:published_at).of_type(DateTime) }
    it { is_expected.to have_field(:raw_data    ).of_type(String).with_default_value_of('') }
    it { is_expected.to have_field(:title       ).of_type(String) }
    it { is_expected.to have_field(:url         ).of_type(String) }
  end

  context 'validations' do
  end

  context 'callbacks' do
  end

  context 'class methods' do
  end

  context 'instance methods' do
  end
end
