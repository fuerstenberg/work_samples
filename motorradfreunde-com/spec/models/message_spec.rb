describe Message do
  context 'general' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to be_timestamped_document }
  end

  context 'concerns' do
  end

  context 'associations' do
    it { is_expected.to belong_to :conversation }
    it { is_expected.to belong_to :recipient }
    it { is_expected.to belong_to :sender }
  end

  context 'fields' do
    it { is_expected.to have_field(:body                      ).of_type(String) }
    it { is_expected.to have_field(:opened                    ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:recipient_delete          ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:recipient_permanent_delete).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:sender_delete             ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:sender_permanent_delete   ).of_type(Mongoid::Boolean).with_default_value_of(false) }
  end

  context 'validations' do
  end

  context 'class methods' do
  end

  context 'instance methods' do
  end
end
