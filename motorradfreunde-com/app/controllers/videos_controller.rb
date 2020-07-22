class VideosController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]

  before_action :set_video, only: [:show, :destroy]
  after_action :count_impression, only: :show

  has_scope :order, only: :index, default: 'impressions_count desc'

  def index
    @videos = apply_scopes(Video)
    if params[:query]
      @videos = @videos.search params[:query], page: params[:page]
    else
      @videos = @videos.page(params[:page]).per 30
    end
    # @videos = Video.where(active: true)
    # if params[:tag]
    #   @tag = Tag.find(params[:tag])
    #   @videos = @videos.tagged_with(@tag.to_s)
    # else
    #   @videos = @videos.order(youtube_view_count: :desc)
    # end
    # @videos = @videos.page(params[:page]).per(30)
  end

  def show
    authorize! :read, @video
  end

  def destroy
    authorize! :destroy, @video
    @video.destroy
    redirect_to :videos, notice: 'Das Video wurde gelöscht.'
  end

  private

  def set_video
    @video = Video.find_by slug: params[:id]
  end

end
