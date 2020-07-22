class ScreensController < ApplicationController

  before_action :set_screen, only: [:show, :edit, :update, :destroy]

  def index
    @screens = Current.customer.screens.all
  end

  def show
    authorize! :read, @screen
  end

  def new
    authorize! :create, Screen
    @screen = Current.customer.screens.build
  end

  def edit
    authorize! :update, @screen
  end

  def create
    @screen = Current.customer.screens.build(screen_params)
    authorize! :create, @screen
    if @screen.save
      redirect_to [@screen.customer, @screen], notice: 'Screen was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize! :update, @screen
    if @screen.update(screen_params)
      redirect_to [@screen.customer, @screen], notice: 'Screen was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @screen
    @screen.destroy
    redirect_to @screen.customer, notice: 'Screen was successfully destroyed.'
  end

  private

  def set_screen
    @screen = Current.customer.screens.find(params[:id])
  end

  def screen_params
    params.require(:screen).permit(:name, address_attributes: [:id, :street, :zip, :city, :country])
  end

end
