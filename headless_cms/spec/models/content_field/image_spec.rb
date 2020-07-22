require "rails_helper"

RSpec.describe ContentField::Image do

  context "general" do
    it { is_expected.to be_kind_of(ContentField::Base) }
  end

  context "associations" do
  end

  context "fields" do
    it { is_expected.to have_field(:has_many).of_type(Mongoid::Boolean) }
  end

  context "validations" do
  end

  context "class methods" do
  end

  context "methods" do
    it "should have has_one?" do
      expect( ContentField::Image.new(has_many: false).has_one? ).to be_truthy
    end

    it "should have has_one" do
      expect( ContentField::Image.new(has_many: false).has_one ).to be_truthy
    end

    it "should generate a singularized field_id when has_many is false on before_validation" do
      content_field = ContentField::Image.new name: "Image", has_many: false
      content_field.valid?
      expect(content_field.field_id).to eq "image"
    end

    it "should generate a pluralized field_id when has_many is true on before_validation" do
      content_field = ContentField::Image.new name: "Image", has_many: true
      content_field.valid?
      expect(content_field.field_id).to eq "images"
      # also for the case that name is already an pluralized name
      content_field = ContentField::Image.new name: "Images", has_many: true
      content_field.valid?
      expect(content_field.field_id).to eq "images"
    end
  end

end
