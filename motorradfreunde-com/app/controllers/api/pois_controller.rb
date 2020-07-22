class Api::PoisController < ApplicationController

  respond_to :json

  skip_before_action :authenticate_user!

  def show
    respond_with Poi.find(params[:id])
  end

end
