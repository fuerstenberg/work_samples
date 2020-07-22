require "rails_helper"

RSpec.describe Content do
  context 'general' do
    it 'should create a content' do
      expect( create(:content).valid? ).to be true
    end

    it 'should create a homer simpson' do
      expect( create(:homer_simpson).valid? ).to be true
    end

    it 'should create an image' do
      expect( create(:an_image).valid? ).to be true
    end

    it 'should create a gallery' do
      expect( create(:a_gallery).valid? ).to be true
    end
  end

  context "concerns" do
    include_examples "content/raw_data_sets"
    include_examples "content/releases"
    include_examples "content/search"
    include_examples "content/sortable"
  end

  context "associations" do
    it { is_expected.to belong_to(:content_type) }
  end

  context "fields" do
    it { is_expected.to have_fields(:_checksum) }
    it { is_expected.to have_fields(:foreign_id) }
  end

  context "validations" do
    it { expect(subject).to receive(:call_before_validation_callback); subject.valid? }
    it { expect(subject).to receive(:call_validation_callback); subject.valid? }
    it { expect(subject).to receive(:presence_of_content_type); subject.valid? }
    it { expect(subject).to receive(:presence_of_customer); subject.valid? }
    it { expect(subject).to receive(:remove_invalid_attributes); subject.valid? }
    it { is_expected.to validate_uniqueness_of(:foreign_id).scoped_to(:customer_id, :content_type_id) }

    it "should be possible to have the same foreign_id for different customers" do
      customer_1 = FactoryBot.create :customer, name: "Customer 1"
      customer_2 = FactoryBot.create :customer, name: "Customer 2"
      content_1 = customer_1.contents.build foreign_id: 1234
      content_1.save validate: false
      expect(content_1).to be_persisted
      content_2 = customer_2.contents.build foreign_id: 1234
      content_2.valid?
      expect(content_2.errors).to_not include :foreign_id
    end

    it "should NOT be possible to have the same foreign_id for the same customer" do
      customer_1 = FactoryBot.create :customer, name: "Customer 1"
      content_1 = customer_1.contents.build foreign_id: "1234"
      content_1.save validate: false
      expect(content_1).to be_persisted
      content_2 = customer_1.contents.build foreign_id: "1234"
      content_2.valid?
      expect(content_2.errors).to include :foreign_id
    end

    it "should be possible to have blank foreign_id for the same customer" do
      customer_1 = FactoryBot.create :customer, name: "Customer 1"
      content_1 = customer_1.contents.build foreign_id: ""
      content_1.save validate: false
      expect(content_1).to be_persisted
      content_2 = customer_1.contents.build foreign_id: ""
      content_2.valid?
      expect(content_2.errors).to_not include :foreign_id
    end

    it "should be invalid without an customer" do
      content = Content.new
      content.valid?
      expect(content.errors).to include :customer
    end

    it "should be invalid without an content_type" do
      content = Content.new
      content.valid?
      expect(content.errors).to include :content_type
    end
  end

  context "class methods" do
  end

  context "methods" do
    let(:content_type) { create :person_content_type }

    it "should remove invalid attributes before validation when a content type is given" do
      attributes = {
        name: "Homer Simpson",
        description: "A popular beer drinker...",
        birthday: Time.now - 38.years,
        goodPerson: true,
        bodySize: 1.84,
        age: 38,
        invalid_attribute: "this should be removed"
      }
      content = content_type.contents.build attributes
      content.valid?
      expect(content.content_type).to eq content_type
      expect(content.attributes[:invalid_attribute]).to be_nil
      expect(content.attributes["invalid_attribute"]).to be_nil
      expect(content[:name       ]).to eq attributes[:name]
      expect(content[:description]).to eq attributes[:description]
      expect(content[:birthday   ]).to eq attributes[:birthday]
      expect(content[:age        ]).to eq attributes[:age]
      expect(content[:bodySize   ]).to eq attributes[:bodySize]
      expect(content[:goodPerson ]).to eq attributes[:goodPerson]
    end

    it "should have all attributes from content type after adding a content type" do
      content = Content.new content_type: content_type
      content_type.content_fields.each do |content_field|
        expect(content).to respond_to content_field.field_id
      end
    end

    it "should have all attributes from content type after adding a content field to an existing content type and edit the content again" do
      content = FactoryBot.create :homer_simpson
      content_field = content.content_type.content_fields.create name: "Job title"
      expect(content_field.field_id).to eq "jobTitle"
      job_title = "Security employee in a nuclear plant"
      content.update_attributes jobTitle: job_title
      expect(content.jobTitle).to eq job_title
    end

    it "should have boolean" do
      content_field = ContentField::Boolean.new name: "Test", field_id: "test"
      content_type = ContentType.new
      allow(content_type).to receive_message_chain("content_fields.all.each").and_yield content_field
      allow(content_type).to receive_message_chain("content_fields.where").with({_type: ContentField::Address}).and_return []
      allow(content_type).to receive_message_chain("content_fields.where").with({_type: ContentField::Image}).and_return []
      content = Content.new content_type: content_type
      expect(content).to respond_to "test"
      expect(content.test).to eq nil
    end

    it "should have short text" do

    end

    it "should have long text" do

    end

    it "should have integer" do

    end

    it "should have decimal" do

    end

    it "should have time" do

    end

    it "should have a image" do

    end

    it "should have many images" do

    end

  end

end
