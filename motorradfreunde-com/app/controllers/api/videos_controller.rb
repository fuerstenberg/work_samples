class Api::VideosController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index]

  def index
    if current_user and current_user.admin?
      @video = Video.not_approved.order("RAND()").first
    else
      @video = Video.active.order("RAND()").first
    end
    render json: @video.to_json
  end

  def show
    @video = Video.find params[:id]
    render json: @video.to_json
  end

  def update
    @video = Video.find(params[:id])
    @video.vote params, current_user
    render json: { success: true }
  end

end
