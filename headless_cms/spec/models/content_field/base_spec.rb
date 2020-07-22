require "rails_helper"

RSpec.describe ContentField::Base do

  context "associations" do
    it { is_expected.to be_embedded_in(:content_type) }
  end

  context "fields" do
    it { is_expected.to have_field(:field_id   ).of_type(String) }
    it { is_expected.to have_field(:localized  ).of_type(Mongoid::Boolean) }
    it { is_expected.to have_field(:name       ).of_type(String) }
    it { is_expected.to have_field(:required   ).of_type(Mongoid::Boolean) }
    it { is_expected.to have_field(:validations).of_type(Array) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:field_id) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:field_id) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  context "class methods" do
  end

  context "methods" do
    it "should fill field id if empty" do
      I18n.locale = :de
      {
        "First name"         => "firstName",
        "First ---- name"    => "firstName",
        "BLÖDER scheiß NAME" => "bloederScheissName",
        "First    name"      => "firstName"
      }.each do |name, field_id|
        subject.name = name
        subject.field_id = ""
        subject.valid?
        expect(subject.field_id).to eq field_id
      end
      I18n.locale = :en
    end
  end

end
