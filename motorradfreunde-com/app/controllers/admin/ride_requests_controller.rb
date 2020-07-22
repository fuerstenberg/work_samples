class Admin::RideRequestsController < Admin::ApplicationController

  def index
    params[:order] ||= "start_at"
    params[:direction] ||= "DESC"
    @ride_requests = RideRequest.order(params[:order] => params[:direction]).page params[:page]
  end

end
