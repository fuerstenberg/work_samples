require "rails_helper"

RSpec.describe "API::Screens::V1::ScreensController", type: :request do
  subject do
    build :screen
  end

  let(:token) { double(:token => "some-token", :acceptable? => true) }
  let(:screen) { create :screen, customer: create(:customer) }

  context "GET /api/v1/screen" do
    before do
      expect_any_instance_of(Api::Screens::V1::ScreensController).to receive(:doorkeeper_token).at_least(1).times { token }
      allow_any_instance_of(Api::Screens::V1::ScreensController).to receive_message_chain("doorkeeper_token.application.owner").and_return screen
      allow(Screen).to receive(:find).with("123").and_return subject
      get "/api/screens/v1/screen"
    end

    it "should respond with json" do
      expect(response.content_type).to eq("application/json")
    end

    it "should respond with status 200" do
      expect(response).to have_http_status(:ok)
    end

    it "should match response schema for screen" do
      expect(response).to match_response_schema("screen")
    end
  end
end
