require 'rails_helper'

describe ContentTypesController do
  let(:customer) { create :customer }
  let(:user) { create :user, :god }
  let(:global_content_type) { create :global_content_type }

  before do
    sign_in user
  end

  describe 'create' do
    context 'copy from global content type' do
      let(:request) { post :create, params: { global_content_type_id: global_content_type.id, customer_id: customer.id } }

      before do
        Current.customer = customer
      end

      it 'copies a content type' do
        expect {
          request
        }.to change {
          Current.customer.content_types.where(name: global_content_type.name).exists?
        }.from(false).to(true)
      end

      it 'copies a content type and its field ids' do
        request
        content_type = Current.customer.content_types.where(name: global_content_type.name).first
        expect(content_type.content_fields.map(&:field_id)).to eq global_content_type.content_fields.map(&:field_id)
      end

      it 'copies a content type and its types' do
        request
        content_type = Current.customer.content_types.where(name: global_content_type.name).first
        expect(content_type.content_fields.map(&:_type)).to eq global_content_type.content_fields.map(&:_type)
      end
    end
  end

end
