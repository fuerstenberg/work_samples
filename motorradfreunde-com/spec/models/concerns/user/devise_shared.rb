shared_examples "an object which accepts devise authentication" do
  context 'general' do
  end

  context 'concerns' do
  end

  context 'associations' do
  end

  context 'fields' do
    it { is_expected.to have_field(:authentication_token  ).of_type(String) }
    it { is_expected.to have_field(:confirmation_sent_at  ).of_type(DateTime) }
    it { is_expected.to have_field(:confirmation_token    ).of_type(String) }
    it { is_expected.to have_field(:confirmed_at          ).of_type(DateTime) }
    it { is_expected.to have_field(:current_sign_in_at    ).of_type(DateTime) }
    it { is_expected.to have_field(:current_sign_in_ip    ).of_type(String) }
    it { is_expected.to have_field(:email                 ).of_type(String) }
    it { is_expected.to have_field(:encrypted_password    ).of_type(String) }
    it { is_expected.to have_field(:failed_attempts       ).of_type(Integer) }
    it { is_expected.to have_field(:last_sign_in_at       ).of_type(DateTime) }
    it { is_expected.to have_field(:last_sign_in_ip       ).of_type(String) }
    it { is_expected.to have_field(:locked_at             ).of_type(DateTime) }
    it { is_expected.to have_field(:old_crypted_password  ).of_type(String) }
    it { is_expected.to have_field(:old_password_salt     ).of_type(String) }
    it { is_expected.to have_field(:password_salt         ).of_type(String) }
    it { is_expected.to have_field(:remember_created_at   ).of_type(DateTime) }
    it { is_expected.to have_field(:reset_password_sent_at).of_type(DateTime) }
    it { is_expected.to have_field(:reset_password_token  ).of_type(String) }
    it { is_expected.to have_field(:sign_in_count         ).of_type(Integer) }
    it { is_expected.to have_field(:unconfirmed_email     ).of_type(String) }
    it { is_expected.to have_field(:unlock_token          ).of_type(String) }
  end

  context 'validations' do
  end

  context 'class methods' do
  end

  context 'instance methods' do
  end
end
