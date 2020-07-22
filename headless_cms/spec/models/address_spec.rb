require "rails_helper"

RSpec.describe Address do

  subject { build :address }

  context "associations" do
    it { is_expected.to be_embedded_in(:addressable) }
  end

  context "fields" do
    it { is_expected.to respond_to :created_at }
    it { is_expected.to respond_to :updated_at }
    it { is_expected.to have_field(:city        ).of_type(String).with_default_value_of("") }
    it { is_expected.to have_field(:coordinates ).of_type(Array ).with_default_value_of([]) }
    it { is_expected.to have_field(:country     ).of_type(String).with_default_value_of("") }
    it { is_expected.to have_field(:country_code).of_type(String).with_default_value_of("") }
    it { is_expected.to have_field(:floor       ).of_type(String).with_default_value_of("") }
    it { is_expected.to have_field(:region      ).of_type(String).with_default_value_of("") }
    it { is_expected.to have_field(:state       ).of_type(String).with_default_value_of("") }
    it { is_expected.to have_field(:street      ).of_type(String).with_default_value_of("") }
    it { is_expected.to have_field(:zip         ).of_type(String).with_default_value_of("") }
  end

  context "callbacks" do
    it "should receive geocode" do
      customer = build :customer
      customer.address = build :address
      customer.address.coordinates = []
      customer.address.geocode
      expect(customer.address.coordinates).not_to be_empty
    end
  end

  context "class methods" do
  end

  context "methods" do
  end

end
