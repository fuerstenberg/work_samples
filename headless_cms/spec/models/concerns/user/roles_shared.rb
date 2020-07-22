RSpec.shared_examples "Concerns::User::Roles" do |parameter|
  let(:customer) { create :customer }
  let(:user) { create :user }

  context "associations" do
    it { is_expected.to embed_many(:roles) }
  end

  context "methods" do
    describe "admin" do
      it "makes a user to admin" do
        user.becomes_admin!
        expect(user).to be_admin
      end
    end

    describe "god" do
      it "makes a user to god" do
        user.becomes_god!
        expect(user).to be_god
      end
    end

    describe "owner" do
      it "makes a user to owner" do
        user.becomes_owner_of! customer: customer
        expect(user).to be_owner_of customer: customer
      end
    end

    describe "editor" do
      it "makes a user to editor" do
        user.becomes_editor_of! customer: customer
        expect(user).to be_editor_of customer: customer
      end
    end
  end

end
