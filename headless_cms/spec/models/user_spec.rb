require "rails_helper"

RSpec.describe User do

  context "concerns" do
    include_examples "Concerns::User::Devise"
    include_examples "Concerns::User::Roles"
  end

  context "fields" do
    it { is_expected.to respond_to :created_at }
    it { is_expected.to respond_to :updated_at }
    it { is_expected.to have_field(:language).of_type(String).with_default_value_of("de") }
    it { is_expected.to have_field(:name    ).of_type(String).with_default_value_of("") }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end

end
