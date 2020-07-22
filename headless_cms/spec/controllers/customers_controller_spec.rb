require 'rails_helper'

describe CustomersController do
  let!(:customer) { create :customer }
  let(:second_customer) { create :customer }

  context 'index' do
    let(:request) { get :index }
    let(:god) { create :user, :god }
    let(:admin) { create :user, :admin }
    let(:editor) { create :user, :editor }

    it 'should render successfully for god user' do
      sign_in god
      request
      expect(response).to be_success
    end

    it 'should render successfully for admin user' do
      sign_in admin
      request
      expect(response).to be_success
    end

    it 'should render successfully for editors with more than one customer' do
      editor.becomes_editor_of! customer: customer
      editor.becomes_editor_of! customer: second_customer
      sign_in editor
      request
      expect(response).to be_success
    end

    it 'should redirect to first customer' do
      sign_in editor
      request
      expect(response.status).to be 302
    end
  end

end
