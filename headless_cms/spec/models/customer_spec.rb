require "rails_helper"

RSpec.describe Customer do

  context 'general' do
    it 'should create a simple customer' do
      expect( create(:customer).valid? ).to be true
    end
  end

  context "concerns" do
    include_examples "address"
    include_examples "Concerns::Customer::Roles"
  end

  context "associations" do
    it { is_expected.to have_many(:content_lists).with_dependent(:restrict_with_error) }
    it { is_expected.to have_many(:content_trees).with_dependent(:restrict_with_error) }
    it { is_expected.to have_many(:content_types).with_dependent(:restrict_with_error) }
    it { is_expected.to have_many(:contents).with_dependent(:restrict_with_error) }
    it { is_expected.to have_many(:screens).with_dependent(:restrict_with_error) }
  end

  context "fields" do
    it { is_expected.to respond_to :created_at }
    it { is_expected.to respond_to :updated_at }
    it { is_expected.to have_field(:name).of_type(String) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end

  context "class methods" do
  end

  context "methods" do
  end

end
