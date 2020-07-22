require "rails_helper"

RSpec.describe Api::Screens::V1::CustomersController, type: :request do

  let(:token) { double(:token => "some-token", :acceptable? => true) }
  let(:customer) { build :customer }
  let(:screen) { build :screen, customer: customer }

  context "/api/screens/v1/customer" do
    before do
      expect_any_instance_of(Api::Screens::V1::CustomersController).to receive(:doorkeeper_token).at_least(1).times { token }
      allow_any_instance_of(Api::Screens::V1::CustomersController).to receive_message_chain("doorkeeper_token.application.owner").and_return screen

      get "/api/screens/v1/customer"
      @result = JSON.parse(response.body)
    end

    it "should respond with content_type json" do
      expect(response.content_type).to eq("application/json")
    end

    it "should respond with status 200" do
      expect(response).to have_http_status(:ok)
    end

    it "should respond with id" do
      expect(@result["customer"]["id"]).to eq customer.id.to_s
    end

    it "should respond with name" do
      expect(@result["customer"]["name"]).to eq customer.name
    end

    it "should respond with screen_ids" do
      expect(@result["customer"]["screen_ids"]).to eq customer.screen_ids
    end

    it "should respond with address id" do
      expect(@result["customer"]["address"]["id"]).to eq customer.address.id.to_s
    end

    it "should respond with address city" do
      expect(@result["customer"]["address"]["city"]).to eq customer.address.city
    end

    it "should respond with address coordinates" do
      expect(@result["customer"]["address"]["coordinates"]).to eq customer.address.to_coordinates
    end

    it "should respond with address country" do
      expect(@result["customer"]["address"]["country"]).to eq customer.address.country
    end

    it "should respond with address country_code" do
      expect(@result["customer"]["address"]["country_code"]).to eq customer.address.country_code
    end

    it "should respond with address floor" do
      expect(@result["customer"]["address"]["floor"]).to eq customer.address.floor
    end

    it "should respond with address state" do
      expect(@result["customer"]["address"]["state"]).to eq customer.address.state
    end

    it "should respond with address street" do
      expect(@result["customer"]["address"]["street"]).to eq customer.address.street
    end

    it "should respond with address zip" do
      expect(@result["customer"]["address"]["zip"]).to eq customer.address.zip
    end

    it "should respond with schema customer" do
      expect(response).to match_response_schema("customer")
    end

  end
end
