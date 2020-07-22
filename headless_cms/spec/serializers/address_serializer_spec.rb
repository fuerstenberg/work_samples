require "rails_helper"

RSpec.describe AddressSerializer, type: :serializer do

  context "Individual Resource Representation" do
    let(:resource) { build(:address) }
    let(:serializer) { AddressSerializer.new(resource) }

    subject do
      expect(resource).to be_valid
      JSON.parse(serializer.to_json) # ["address"]
    end

    it "has a id" do
      expect(subject["id"]).to eql(resource.id.to_s)
    end

    it "has coordinates" do
      expect(subject["coordinates"]).to eql(resource.to_coordinates)
    end

    it "has a street" do
      expect(subject["street"]).to eql(resource.street)
    end

    it "has a zip" do
      expect(subject["zip"]).to eql(resource.zip)
    end

    it "has a city" do
      expect(subject["city"]).to eql(resource.city)
    end

    it "has a state" do
      expect(subject["state"]).to eql(resource.state)
    end

    it "has a country" do
      expect(subject["country"]).to eql(resource.country)
    end

    it "has a country_code" do
      expect(subject["country_code"]).to eql(resource.country_code)
    end

    it "has a floor" do
      expect(subject["floor"]).to eql(resource.floor)
    end

    it "has a created_at" do
      expect(subject["created_at"]).to eql(resource.created_at)
    end

    it "has a updated_at" do
      expect(subject["updated_at"]).to eql(resource.updated_at)
    end

  end

end
