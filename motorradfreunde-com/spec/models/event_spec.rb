describe Event do
  context 'general' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to be_timestamped_document }
  end

  context 'concerns' do
    it_behaves_like "embeds one address", FactoryGirl.create(:event, :with_address)
    it_behaves_like "embeds many comments", FactoryGirl.create(:event)
    it_behaves_like "has impressions"
    it_behaves_like "has many activities", :event
  end

  context 'associations' do
    it { is_expected.to belong_to :user }
  end

  context 'fields' do
    it { is_expected.to have_field(:description     ).of_type(String) }
    it { is_expected.to have_field(:description_html).of_type(String) }
    it { is_expected.to have_field(:end_at          ).of_type(Date) }
    it { is_expected.to have_field(:hide_time       ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:import_url      ).of_type(String) }
    it { is_expected.to have_field(:start_at        ).of_type(Date) }
    it { is_expected.to have_field(:title           ).of_type(String) }
    it { is_expected.to have_field(:url             ).of_type(String) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:start_at) }
    it { is_expected.to validate_presence_of(:title) }
    it 'should validate, that the start_at is less than (time now - 2 hours)'
    it 'should validate, that the end_at is greater than or equal to start_at'
    it 'should validate, that the title is uniq for the same date range and location'
  end

  context 'class methods' do
  end

  context 'instance methods' do
  end
end
