require 'rails_helper'

describe Api::Customers::V1::ImagesController do
  let!(:customer) { create :customer }
  let!(:content) { create :an_image }
  let(:image_file) { fixture_file_upload(File.open(Rails.root + 'spec/support/test_500_500.png'), 'image/png') }
  let(:token) { double :acceptable? => true }
  let(:image_json) { JSON.parse ImageSerializer.new(content.image, root: true).to_json }

  before do
    Current.customer = customer
    allow(controller).to receive(:doorkeeper_token) { token } # => RSpec 3
    allow(controller).to receive_message_chain('doorkeeper_token.application').and_return( double(:application, owner: content.customer) )
  end

  describe '#index' do
    before { get :index, params: { content_id: content.id } }
    specify {
      expect(response.status).to eq 200
      expect(JSON.parse(response.body)['images']).to eq [image_json]
    }
  end

  describe '#show' do
    before { get :show, params: { content_id: content.id, id: content.image.id } }
    specify {
      expect(response.status).to eq 200
      expect(JSON.parse(response.body)['image']).to eq image_json
    }
  end

  describe '#create' do
    context 'has_one image' do
      before { post :create, params: { content_id: content.id, image_attributes: { file: image_file } } }
      specify {
        expect(response.status).to eq 200
      }
    end

    context 'has_many images' do
      let(:a_gallery) { create :a_gallery }
      let(:image_file) { fixture_file_upload(File.open(Rails.root + 'spec/support/test_5000_5000.png'), 'image/png') }

      before do
        allow(controller).to receive_message_chain('doorkeeper_token.application').and_return( double(:application, owner: a_gallery.customer) )
        post :create, params: { content_id: a_gallery.id, images_attributes: { file: image_file } }
      end
      specify {
        expect(response.status).to eq 200
      }
    end

    context 'has_many images but prevent duplicates' do
      let!(:a_gallery) { create :a_gallery }
      before do
        allow(controller).to receive_message_chain('doorkeeper_token.application').and_return( double(:application, owner: a_gallery.customer) )
        post :create, params: { content_id: a_gallery.id, images_attributes: { file: image_file } }
      end
      specify { expect(response.status).to eq 422 }
      specify { expect(JSON.parse(response.body)["file_hash"]).to eq ["is already taken"] }
    end
  end

  describe '#destroy' do
    before { delete :destroy, params: { content_id: content.id, id: content.image.id } }
    specify {
      expect(content.reload.image).to be nil
      expect(response.status).to eq 200
    }
  end
end
