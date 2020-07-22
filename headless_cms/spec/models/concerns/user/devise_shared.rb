RSpec.shared_examples "Concerns::User::Devise" do |parameter|

  context "validations" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end

end
