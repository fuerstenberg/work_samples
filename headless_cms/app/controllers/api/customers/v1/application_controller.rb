class Api::Customers::V1::ApplicationController < Api::ApplicationController

  # before_action only: [:index, :show] do
  #   doorkeeper_authorize! :public
  # end
  #
  # before_action only: [:create, :update, :destroy] do
  #   doorkeeper_authorize! :admin, :write
  # end
  before_action :doorkeeper_authorize!, only: [:index, :show, :create, :update, :destroy]
  before_action :set_customer

  protected

  def set_customer
    if doorkeeper_token and doorkeeper_token.application
      Current.customer = @customer = doorkeeper_token.application.owner
    end
  end

end
