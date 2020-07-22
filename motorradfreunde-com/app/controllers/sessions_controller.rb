class SessionsController < ApplicationController

  # layout 'login'
  skip_before_action :require_no_authentication
  before_filter :resource_name

  # def resource_name
  #   :user
  # end

  # def index
  # end

  # def new
  #   @user = User.new
  # end

  def create
    if user_params
      @user = User.new user_params
    elsif session_params
    end
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit([
      :name,
      :email,
      :password,
      :password_confirmation
    ])
  end

end
