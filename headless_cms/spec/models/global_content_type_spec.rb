require "rails_helper"

RSpec.describe GlobalContentType do
  context 'general' do
    it 'should create a simple global_content_type' do
      expect( create(:global_content_type).valid? ).to be true
    end
  end

  context 'concerns' do
    include_examples "shared/content_type"
  end

  context "associations" do
  end

  context "fields" do
  end

  context "validations" do
  end

  context "class methods" do
  end

  context "methods" do
    context "build_content_type_for_customer" do
      let(:customer) { create :customer }

      before do
        Current.customer = customer
      end

      xit "should return a content type for a customer as a copy of a global content type" do
        # TODO: FIX THIS TEST IT IS IMPORTANT, THE METHOD ITSELF WORKS BUT IS NOT SO NICE
        global_content_type = create :global_content_type_person
        global_content_type.reload
        content_type = global_content_type.build_content_type_for_customer customer
        content_type.save
        expect(content_type.customer).to eq customer
        expect(content_type.content_fields.size).to eq global_content_type.content_fields.size
      end
    end
  end
end
