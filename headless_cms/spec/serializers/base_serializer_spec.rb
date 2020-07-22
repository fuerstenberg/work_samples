require "rails_helper"

RSpec.describe BaseSerializer, type: :serializer do

  context "Individual Resource Representation" do
    # let(:resource) { build(:address) }
    # let(:serializer) { AddressSerializer.new(resource) }
    #
    # subject do
    #   JSON.parse(serializer.to_json)["address"]
    # end
    #
    # it "has a id" do
    #   expect(subject["id"]).to eql(resource.id.to_s)
    # end

    it "has a updated_at" do
      skip "TODO: expect(every attribute).not_to be_nil"
      expect(subject["updated_at"]).to eql(resource.updated_at)
    end

    it "has a created_at" do
      skip "TODO: expect(every attribute).not_to be_nil"
      expect(subject["updated_at"]).to eql(resource.updated_at)
    end
  end

end
