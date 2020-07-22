require "rails_helper"

RSpec.describe "Api::Customers::V1::ContentsController", type: :request do
  let!(:customer) { create :customer }

  context "GET /api/customers/v1/contents" do
    let(:token) { double(:token => "some-token", :acceptable? => true) }
    let(:content) { create :homer_simpson }

    before do
      expect_any_instance_of(Api::Customers::V1::ContentsController).to receive(:doorkeeper_token).at_least(1).times { token }
      allow_any_instance_of(Api::Customers::V1::ContentsController).to receive_message_chain("doorkeeper_token.application.owner").and_return Current.customer
    end

    it "should return a empty list" do
      get "/api/customers/v1/contents"
      expect(response).to match_response_schema("empty_contents")
    end

    it "should return a list of ids" do
      get "/api/customers/v1/contents"
      expect(response).to match_response_schema("contents")
    end
  end

  context "GET /api/customers/v1/contents/456" do
    let(:token) { double(:token => "some-token", :acceptable? => true) }
    let(:content) { create :homer_simpson }

    before do
      expect_any_instance_of(Api::Customers::V1::ContentsController).to receive(:doorkeeper_token).at_least(1).times { token }
      allow_any_instance_of(Api::Customers::V1::ContentsController).to receive_message_chain("doorkeeper_token.application.owner").and_return Current.customer

      get "/api/customers/v1/contents/#{content.id}"
    end

    it "should return a content" do
      expect(response).to match_response_schema("content")
    end
  end

  context "POST /api/customers/v1/contents" do
    let(:token) { double(:token => "some-token", :acceptable? => true) }
    let(:content) { create :homer_simpson }
    let(:json){ JSON.parse response.body }

    before do
      expect_any_instance_of(Api::Customers::V1::ContentsController).to receive(:doorkeeper_token).at_least(1).times { token }
      allow_any_instance_of(Api::Customers::V1::ContentsController).to receive_message_chain("doorkeeper_token.application.owner").and_return Current.customer
    end

    it "should create a content" do
      post "/api/customers/v1/content_types/#{content.content_type_id}/contents", params: { content: attributes_for(:homer_simpson), format: :json }
      # TODO: expect(response).to serialize_object(content).with(ContentSerializer)
      expect(response.status).to eq 200
    end

    it "should not create a content" do
      post "/api/customers/v1/content_types/#{content.content_type_id}/contents", params: { content: { invalid_attribute: "here" }, format: :json }
      attributes = attributes_for(:homer_simpson)
      attributes.delete :customer
      expect( json['name'] ).to eq ["can't be blank"]
      expect( json['description'] ).to eq ["can't be blank"]
      expect( json['birthday'] ).to eq ["can't be blank"]
      expect( json['goodPerson'] ).to eq ["can't be blank"]
      expect( json['bodySize'] ).to eq ["can't be blank"]
      expect( json['age'] ).to eq ["can't be blank"]
      expect(response.status).to eq 422
    end
  end

  context "PUT /api/customers/v1/contents/456" do
    let(:token) { double(:token => "some-token", :acceptable? => true) }
    let(:content) { create :homer_simpson }
    let(:json){ JSON.parse response.body }

    before do
      expect_any_instance_of(Api::Customers::V1::ContentsController).to receive(:doorkeeper_token).at_least(1).times { token }
      allow_any_instance_of(Api::Customers::V1::ContentsController).to receive_message_chain("doorkeeper_token.application.owner").and_return Current.customer
    end

    it "should update a content" do
      put "/api/customers/v1/contents/#{content.id}", params: { content: attributes_for(:homer_simpson) }
      # TODO:  expect(response).to serialize_object(content).with(ContentSerializer)
      expect(response.status).to eq 200
    end

    it "should not update a content" do
      put "/api/customers/v1/contents/#{content.id}", params: { content: { name: nil } }
      expect( json["name"] ).to eq ["can't be blank"]
      expect(response.status).to eq 422
    end
  end

  context "DELETE /api/customers/v1/contents/456" do
    let(:token) { double(:token => "some-token", :acceptable? => true) }
    let(:content) { create :homer_simpson }

    before do
      expect_any_instance_of(Api::Customers::V1::ContentsController).to receive(:doorkeeper_token).at_least(1).times { token }
      allow_any_instance_of(Api::Customers::V1::ContentsController).to receive_message_chain("doorkeeper_token.application.owner").and_return Current.customer

      delete "/api/customers/v1/contents/#{content.id}"
    end

    it "should delete a content" do
      expect(response).to match_response_schema("content")
    end

    it "should return status 200" do
      expect(response.status).to eq 200
    end
  end

end
