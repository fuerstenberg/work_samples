class Api::UsersController < ApplicationController

  respond_to :json

  skip_before_action :authenticate_user!

  def index
    respond_with (User.in_bounds(params[:bounds]).limit(params[:zoom].to_i * 15) - [current_user]), :only => [:latitude, :longitude, :id, :name], :methods => [:avatar, :to_s]
  end

end
