require "rails_helper"

RSpec.describe AdminRole do
  let(:user) { create :user }
  let(:customer) { create :customer }
  subject { AccessPolicy.new user }

  before do
    user.becomes_admin!
    Current.customer = customer
  end

  context 'Content' do
    let(:content) { create :content, customer: customer }

    it { expect( subject.can? :read,    content ).to be true }
    it { expect( subject.can? :create,  content ).to be true }
    it { expect( subject.can? :update,  content ).to be true }
    it { expect( subject.can? :destroy, content ).to be true }
  end

  context 'ContentField' do
    let(:content_type) { create :person_content_type, customer: customer }
    let(:content_field) { content_type.content_fields.first }

    it { expect( subject.can? :read,    content_field ).to be true }
    it { expect( subject.can? :create,  content_field ).to be true }
    it { expect( subject.can? :update,  content_field ).to be true }
    it { expect( subject.can? :destroy, content_field ).to be true }
  end

  context 'ContentType' do
    let(:content_type) { create :content_type, customer: customer }

    it { expect( subject.can? :read,    content_type ).to be true }
    it { expect( subject.can? :create,  content_type ).to be true }
    it { expect( subject.can? :update,  content_type ).to be true }
    it { expect( subject.can? :destroy, content_type ).to be true }
  end

  context 'Customer' do
    let(:customer) { create :customer }

    it { expect( subject.can? :read,    customer ).to be true }
    it { expect( subject.can? :create,  customer ).to be true }
    it { expect( subject.can? :update,  customer ).to be true }
    it { expect( subject.can? :destroy, customer ).to be true }
  end

  context 'GlobalContentType' do
    let(:global_content_type) { create :global_content_type }

    it { expect( subject.can? :read,    global_content_type ).to be false }
    it { expect( subject.can? :create,  global_content_type ).to be false }
    it { expect( subject.can? :update,  global_content_type ).to be false }
    it { expect( subject.can? :destroy, global_content_type ).to be false }
  end

  context 'Release' do
    let(:content) { create :content, customer: customer }
    let!(:screen) { create :screen, customer: customer }

    before :each do
      content.release_for_all_screens
      content.save
    end

    it { expect( subject.can? :read,    content.releases.first ).to be true }
    it { expect( subject.can? :create,  content.releases.first ).to be true }
    it { expect( subject.can? :update,  content.releases.first ).to be true }
    it { expect( subject.can? :destroy, content.releases.first ).to be true }
  end

  context 'Role' do
    describe 'god role' do
      let(:role) { create(:user).becomes_god! }

      it { expect( subject.can? :read,    role ).to be false }
      it { expect( subject.can? :create,  role ).to be false }
      it { expect( subject.can? :update,  role ).to be false }
      it { expect( subject.can? :destroy, role ).to be false }
    end

    describe 'admin role' do
      let(:role) { create(:user).becomes_admin! }

      it { expect( subject.can? :read,    role ).to be false }
      it { expect( subject.can? :create,  role ).to be false }
      it { expect( subject.can? :update,  role ).to be false }
      it { expect( subject.can? :destroy, role ).to be false }
    end

    describe 'owner role' do
      let(:role) { create(:user).becomes_owner_of! customer: customer }

      it { expect( subject.can? :read,    role ).to be true }
      it { expect( subject.can? :create,  role ).to be true }
      it { expect( subject.can? :update,  role ).to be true }
      it { expect( subject.can? :destroy, role ).to be true }
    end

    describe 'editor role' do
      let(:role) { create(:user).becomes_editor_of! customer: customer }

      it { expect( subject.can? :read,    role ).to be true }
      it { expect( subject.can? :create,  role ).to be true }
      it { expect( subject.can? :update,  role ).to be true }
      it { expect( subject.can? :destroy, role ).to be true }
    end
  end

  context 'Screen' do
    let(:screen) { create :screen, customer: customer }

    it { expect( subject.can? :read,    screen ).to be true }
    it { expect( subject.can? :create,  screen ).to be true }
    it { expect( subject.can? :update,  screen ).to be true }
    it { expect( subject.can? :destroy, screen ).to be true }
  end

  context 'User' do
    let(:user) { create :user }

    it { expect( subject.can? :read,    user ).to be true }
    it { expect( subject.can? :create,  user ).to be true }
    it { expect( subject.can? :update,  user ).to be true }
    it { expect( subject.can? :destroy, user ).to be true }
  end
end
