class Api::Screens::V1::CustomersController < Api::Screens::V1::ApplicationController

  def show
    render json: @screen.customer
  end

end
