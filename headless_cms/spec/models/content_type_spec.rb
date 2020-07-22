require "rails_helper"

RSpec.describe ContentType do
  context 'general' do
    it 'should create a simple content_type' do
      expect( create(:content_type).valid? ).to be true
    end
  end

  context 'concerns' do
    include_examples "shared/content_type"
  end

  context "associations" do
    it { is_expected.to belong_to(:customer) }
    it { is_expected.to have_many(:contents) }
  end

  context "fields" do
  end

  context "validations" do
  end

  context "class methods" do
  end

  context "methods" do
  end

end
