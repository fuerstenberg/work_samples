require "rails_helper"

RSpec.describe Role do

  context 'general' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to respond_to :created_at }
    it { is_expected.to respond_to :updated_at }

    it 'should create an admin' do
      admin = create :user, :admin
      expect(admin).to be_persisted
      expect(admin).to be_admin
    end
  end

  context "constants" do
    it { expect(described_class::CUSTOMER_DEPENDENT_TYPES).to eq [:editor, :owner] }
    it { expect(described_class::CUSTOMER_INDEPENDENT_TYPES).to eq [:god, :admin] }
    it { expect(described_class::TYPES).to eq(described_class::CUSTOMER_DEPENDENT_TYPES + described_class::CUSTOMER_INDEPENDENT_TYPES) }
  end

  context "associations" do
    it { is_expected.to be_embedded_in(:user) }
    it { is_expected.to belong_to(:customer) }
  end

  context "fields" do
    it { is_expected.to have_field(:type).of_type(Symbol).with_default_value_of(:editor) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:type) }
  end

end
