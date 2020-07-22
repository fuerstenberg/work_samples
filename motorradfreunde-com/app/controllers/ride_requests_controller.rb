class RideRequestsController < ApplicationController

  before_action :set_ride_request, only: [:show, :destroy]
  after_filter :count_impression, only: :show

  def show
    authorize! :read, @ride_request
  end

  # def create
  #   @ride_request = current_user.ride_requests.build ride_request_params
  #   respond_to do |format|
  #     if @ride_request.save
  #       format.html{ redirect_to @ride_request }
  #       format.json{ render json: @ride_request }
  #     else
  #       format.html{ redirect_to root_url }
  #       format.json{ render json: { errors: @ride_request.errors } }
  #     end
  #   end
  # end

  def destroy
    authorize! :destroy, @ride_request
    @ride_request.update_attribute :deleted, true
    redirect_to @ride_request, notice: I18n.t("controller.ride_requests.destroy.notice")
  end

  private

  def ride_request_params
    params.require(:ride_request).permit :start_at, :user_id, :driving_style
  end

  def set_ride_request
    @ride_request = RideRequests.find params[:id]
  end

end
