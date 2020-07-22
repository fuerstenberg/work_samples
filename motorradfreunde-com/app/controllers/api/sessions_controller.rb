class Api::SessionsController < ApplicationController

  respond_to :json

  def show
    render json: current_user, root: false
  end

  def update
    authorize! :update, current_user
    current_user.update_attributes address_attributes: allowed_params
    render json: current_user, root: false
  end

  private

  def allowed_params
    params.require(:session).permit :latitude, :longitude
  end

end
