require "rails_helper"

RSpec.describe "Api::Screens::V1::ContentsController", type: :request do
  let(:token)    { double(:token => "some-token", :acceptable? => true) }
  let(:customer) { create :customer }
  let(:screen_1)   { create :screen, customer: customer }
  let(:screen_2)   { create :screen, customer: customer }
  let(:content)  { create :homer_simpson, customer: customer }

  before :each do
    expect_any_instance_of(Api::Screens::V1::ContentsController).to receive(:doorkeeper_token).at_least(1).times { token }
    allow_any_instance_of(Api::Screens::V1::ContentsController).to receive_message_chain("doorkeeper_token.application.owner").and_return screen_1
    expect_any_instance_of(Api::Screens::V1::ApplicationController).to receive(:touch_last_api_get_request).at_least(1).times
  end

  context "GET /api/screens/v1/contents" do
    before :each do
      content.releases.create screen: screen_1
      expect(content).to     have_released_for_screen screen_1
      expect(content).to_not have_released_for_screen screen_2
    end

    it "should return an empty list" do
      content.releases.delete_all
      content.releases.create screen: screen_2
      get "/api/screens/v1/contents"
      expect(response.body).to_not include content.id.to_s
      expect(response).to match_response_schema("empty_contents")
    end

    it "should return only released content for that screen" do
      get "/api/screens/v1/contents"
      expect(response.body).to include content.id.to_s
      expect(response).to match_response_schema("contents")
    end

    it "should return an list of multiple contents" do
      content_2 = create :homer_simpson, customer: customer
      content_2.releases.create screen: screen_1
      get "/api/screens/v1/contents"
      expect(response).to match_response_schema("contents")
      expect(response.body).to include content.id.to_s
      expect(response.body).to include content_2.id.to_s
    end

    it "should return a content released via auto_publish" do
      content_type = create :person_content_type, auto_publish: true
      content = create :homer_simpson, customer: customer, content_type: content_type
      get "/api/screens/v1/contents"
      expect(response).to match_response_schema("contents")
      expect(response.body).to include content.id.to_s
    end
  end

  context "GET /api/screens/v1/contents/456" do
    it "should return a content" do
      get "/api/screens/v1/contents/#{content.id}"
      expect(response).to match_response_schema("content")
    end
  end
end
