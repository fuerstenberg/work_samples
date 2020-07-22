require "rails_helper"

RSpec.describe Release do

  context "associations" do
    it { is_expected.to be_embedded_in(:content) }
    it { is_expected.to belong_to(:screen) }
  end

  context "fields" do
    xit { is_expected.to have_field(:order   ).of_type(Integer).with_default_value_of(0) }
    xit { is_expected.to have_field(:start_at).of_type(DateTime) }
    xit { is_expected.to have_field(:end_at  ).of_type(DateTime) }
  end

  context "validations" do
    it { is_expected.to validate_uniqueness_of(:screen_id) }
  end

  context "class methods" do
  end

  context "methods" do
  end

end
