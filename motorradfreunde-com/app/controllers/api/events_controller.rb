class Api::EventsController < ApplicationController

  respond_to :json

  skip_before_action :authenticate_user!

  def index
    respond_with Event.find_for_map(params[:bounds], params[:zoom]), :only => [:id, :latitude, :longitude, :title, :start_at, :end_at]
  end

end
