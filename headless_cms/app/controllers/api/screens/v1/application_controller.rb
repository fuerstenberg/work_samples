class Api::Screens::V1::ApplicationController < Api::ApplicationController

  # before_action only: [:index, :show] do
  #   doorkeeper_authorize! :public
  # end
  #
  # before_action only: [:create, :update, :destroy] do
  #   doorkeeper_authorize! :admin, :write
  # end
  before_action :doorkeeper_authorize!, only: [:index, :show, :create, :update, :destroy]
  before_action :set_screen
  before_action :touch_last_api_get_request

  protected

  # before_action
  def set_screen
    if doorkeeper_token and doorkeeper_token.application
      @screen = doorkeeper_token.application.owner
      @customer = @screen.customer
      Current.customer = @customer
    end
  end

  # before_action
  def touch_last_api_get_request
    @screen.touch :last_api_get_request
  end

end
