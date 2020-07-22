class Api::AccountsController < ApplicationController

  respond_to :json

  before_filter :authenticate_user!

  def update
    authorize! :update, current_user
    respond_with User.update current_user, {lat: params[:account][:lat], lng: params[:account][:lng]}
  end

end
