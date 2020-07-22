class RoutesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]
  before_filter :set_route, only: [:show, :edit, :update, :destroy]
  after_filter :count_impression, only: :show

  has_scope :by_user, only: [:index], as: :user_id
  has_scope :order, default: 'created_at desc'
  has_scope :current_user, only: [:index], type: :boolean do |controller, scope, value|
    if controller.current_user
      scope.by_user(controller.current_user)
    else
      scope
    end
  end
  has_scope :near do |controller, scope, value|
    if controller.current_user and controller.current_user.geocoded?
      scope.near_by(controller.current_user, value.to_i)
    else
      scope
    end
  end

  def index
    @routes = apply_scopes(Route)
    if params[:query]
      @routes = @routes.search params[:query], page: params[:page]
    else
      @routes = @routes.page(params[:page]).per 30
    end
  end

  def show
    authorize! :read, @route
    gon.push route: @route
    respond_to do |format|
      format.html
      format.json { render json: @route }
    end
  # rescue Mongoid::Errors::DocumentNotFound => e
  #   render nothing: true, status: 301
  end

  def new
    authorize! :create, Route
    @route = current_user.routes.build
    respond_to do |format|
      format.html
      format.json { render json: @route }
    end
  end

  def create
    authorize! :create, Route
    @route = current_user.routes.build route_params
    respond_to do |format|
      if @route.save
        format.html { redirect_to @route, notice: 'Route was successfully created.' }
        format.json { render json: @route, status: :created, location: @route }
      else
        format.html { render action: "new" }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    authorize! :update, @route
  end

  def update
    authorize! :update, @route
    respond_to do |format|
      if @route.update_attributes(route_params)
        format.html { redirect_to @route, notice: 'Route was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize! :destroy, @route
    @route.destroy
    respond_to do |format|
      format.html { redirect_to :routes }
      format.json { head :no_content }
    end
  end

  private

  def set_route
    @route = Route.find_by slug: params[:id]
  end

  def route_params
    params.require(:route).permit!
  end

end
