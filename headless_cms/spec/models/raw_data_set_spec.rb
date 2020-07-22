require "rails_helper"

RSpec.describe RawDataSet do
  context "associations" do
    it { is_expected.to belong_to(:content) }
  end

  context "fields" do
    it { is_expected.to have_fields(:xml) }
  end
end
