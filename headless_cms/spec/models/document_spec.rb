require "rails_helper"

RSpec.describe Document do

  context "associations" do
    it { is_expected.to be_embedded_in(:documentable) }
  end

  context "fields" do
    it { is_expected.to have_fields(:copyright) }
    it { is_expected.to have_fields(:file_hash) }
    it { is_expected.to have_fields(:title) }
  end

  context "validations" do
    it { is_expected.to validate_uniqueness_of(:file_hash) }
  end

  context "class methods" do
  end

  context "methods" do
  end

end
