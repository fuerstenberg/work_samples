require "rails_helper"

RSpec.describe CustomerSerializer, type: :serializer do

  context "Individual Resource Representation" do
    let(:resource) { create(:customer, :with_screens) }
    let(:serializer) { CustomerSerializer.new(resource) }

    subject do
      expect(resource).to be_valid
      JSON.parse(serializer.to_json) # ["customer"]
    end

    it "has a id" do
      expect(subject["id"]).to eql(resource.id.to_s)
    end

    it "has a name" do
      expect(subject["name"]).to eql(resource.name)
    end

    it "has a address" do
      address = JSON.parse AddressSerializer.new(resource.address).to_json
      expect(subject["address"]).to eql( address )
    end

    it "has screen_ids" do
      expect(resource.screens).not_to be_empty
      expect(subject["screen_ids"]).to eql resource.screens.map(&:id).map(&:to_s)
    end

  end

end
