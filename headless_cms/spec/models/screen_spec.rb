require "rails_helper"

RSpec.describe Screen do

  context "concerns" do
    include_examples "Concerns::Screen::ContentList"
    include_examples "Concerns::Screen::ContentTree"
    include_examples "Concerns::Screen::Releases"
  end

  context "associations" do
    it { is_expected.to belong_to(:customer) }
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
    # it "should return all its real estates" do
    #   expect(subject).to receive_message_chain("pages.real_estates")
    #   subject.real_estates
    # end
  end

end
