require "rails_helper"

RSpec.describe ScreenSerializer, type: :serializer do

  context "Individual Resource Representation" do
    let(:resource) { build(:screen, customer: build(:customer)) }
    let(:serializer) { ScreenSerializer.new(resource) }

    subject do
      expect(resource).to be_valid
      JSON.parse(serializer.to_json) # ["screen"]
    end

    it "has a id" do
      expect(subject["id"]).to eql(resource.id.to_s)
    end

    it "has a customerId" do
      expect(subject["customerId"]).to eql(resource.customer_id.to_s)
    end

    it "has a name" do
      expect(subject["name"]).to eql(resource.name)
    end

    # it "has a address" do
    #   address = JSON.parse AddressSerializer.new(resource.address).to_json
    #   expect(subject["address"]).to eql( address["address"] )
    # end
  end

end
