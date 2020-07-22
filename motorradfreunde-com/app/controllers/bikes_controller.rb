class BikesController < ApplicationController

  layout 'fullscreen_formular', only: [:new, :create, :edit, :update]

  skip_before_action :authenticate_user!, only: [:index, :show]
  before_filter :set_bike, only: [:show, :edit, :update, :destroy]
  after_filter :count_impression, only: :show

  has_scope :by_user,      only: [:index], as: :user_id
  has_scope :by_vendor,    only: [:index], as: :poi_id
  has_scope :current_user, only: [:index], type: :boolean do |controller, scope|
    if controller.current_user
      scope.by_user(controller.current_user.id)
    else
      scope
    end
  end

  def index
    @bikes = apply_scopes(Bike).order_by_has_images.recent
    if params[:query]
      @bikes = @bikes.search params[:query], page: params[:page]
    else
      @bikes = @bikes.page(params[:page]).per 30
    end
  end

  def show
    authorize! :read, @bike
  end

  def new
    authorize! :create, Bike
    @bike = current_user.bikes.build
    4.times{ @bike.images.build }
  end

  def create
    authorize! :create, Bike
    @bike = current_user.bikes.build bike_params
    if @bike.save
      redirect_to vendor_bike_url(@bike.vendor, @bike), notice: I18n.t("controller.bikes.create.notice")
    else
      render :new
    end
  end

  def edit
    authorize! :update, @bike
  end

  def update
    authorize! :update, @bike
    if @bike.update_attributes(bike_params)
      redirect_to vendor_bike_url(@bike.vendor, @bike), notice: I18n.t("controller.bikes.update.notice")
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @bike
    @bike.destroy
    redirect_to vendor_bikes_url(@bike.vendor), notice: I18n.t("controller.bikes.destroy.notice")
  end

  private

  def set_bike
    @bike = Bike.find_by slug: params[:id]
  rescue Mongoid::Errors::DocumentNotFound => e
    render nothing: true, status: 301
  end

  def bike_params
    params.require(:bike).permit :model, :ccm, :hp, :year_of_manufacture, :color, :description, :category, :property, :permalink, :poi_id
  end

end
