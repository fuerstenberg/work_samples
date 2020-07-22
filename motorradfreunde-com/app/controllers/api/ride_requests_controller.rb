class Api::RideRequestsController < ApplicationController

  respond_to :json

  def create
    authorize! :create, RideRequest
    @ride_request = current_user.ride_requests.build ride_request_params
    if @ride_request.save
      respond_with @ride_request
    else
      respond_with @ride_request
    end
  end

  private

  def ride_request_params
    params.require(:ride_request).permit :start_at, :driving_style
  end

end
