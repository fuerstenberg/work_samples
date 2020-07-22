class Api::Customers::V1::CustomersController < Api::Customers::V1::ApplicationController

  respond_to :json

  def show
    render json: @customer
  end

end
