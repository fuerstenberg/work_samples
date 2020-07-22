class PoisController < ApplicationController

  layout 'fullscreen_formular', only: [:new, :create, :edit, :update]

  skip_before_action :authenticate_user!, only: [:index, :show]
  before_filter :set_poi, only: [:show, :edit, :update, :destroy]
  after_filter :count_impression, only: :show

  # has_scope :tag_id, only: [:index] do |controller, scope, value|
  #   tag = Tag.find(value)
  #   scope.tagged_with(tag)
  # end

  has_scope :near, default: "3000" do |controller, scope, value|
    if controller.current_user and controller.current_user.geocoded?
      scope.near_by(controller.current_user, value.to_i)
    else
      scope.order(impressions_count: :desc)
    end
  end


  def index
    # @tag = Tag.find params[:tag_id] if params[:tag_id].present?
    tag = params[:tag_id].present? ? params[:tag_id][(params[:tag_id].index('-') + 1)..-1] : nil
    @pois = apply_scopes(Poi).order_by_has_images.recent
    if tag
      redirect_to searches_url(search: {query: tag}), status: 301
    else
      @pois = @pois.page(params[:page]).per 30
    end
  end

  def show
    authorize! :read, @poi
  end

  def new
    authorize! :create, Poi
    @poi = Poi.new
  end

  def create
    authorize! :create, Poi
    @poi = Poi.new allowed_params
    @poi.creator = current_user

    if @poi.save
      SlackNotificationWorker.perform_async "POI created, [#{@poi}](#{poi_url(@poi)})."
      redirect_to @poi, notice: I18n.t('poi.flash.create.successfully')
    else
      render :new
    end
  end

  def edit
    authorize! :update, @poi
  end

  def update
    authorize! :update, @poi
    @poi.editor = current_user
    @poi.attributes = allowed_params
    if @poi.save
      SlackNotificationWorker.perform_async "POI updated, [#{@poi}](#{poi_url(@poi)})."
      redirect_to @poi, notice: I18n.t('poi.flash.update.successfully')
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @poi
    @poi.destroy
    redirect_to :pois, notice: I18n.t('poi.flash.destroy.successfully')
  end

  private

  def set_poi
    @poi = Poi.find_by slug: params[:id]
  end

  def allowed_params
    params.require(:poi).permit! #.permit *Poi.allowed_attributes
  end

end
