require 'rails_helper'

RSpec.describe "UsersController", type: :request do
  let(:god) { create :user, :god }

  describe "GET /users" do
    before do
      sign_in god
    end

    it "should render all users" do
      get users_path
      expect(response).to have_http_status(200)
      User.all.each do |user|
        expect(response.body).to include user.name
      end
    end
  end

  describe "POST /users" do
    let(:user_attributes) { attributes_for(:user) }

    before do
      sign_in god
    end

    it 'should create successfully' do
      post users_path, params: { user: user_attributes }
      user = User.find_by email: user_attributes[:email]
      expect(response).to redirect_to user_path(user)
    end
  end
end
