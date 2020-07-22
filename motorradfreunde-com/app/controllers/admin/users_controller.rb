class Admin::UsersController < Admin::ApplicationController

  def index
    params[:order] ||= "name"
    params[:direction] ||= "ASC"
    @users = User.order(params[:order] => params[:direction]).page params[:page]
  end

  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new :terms_of_service => true
  end

  def create
    @user = User.new user_params
    @user.terms_of_service = true if @user.commercial?
    if @user.save
      redirect_to [:admin, :users], :notice => "Benutzer erfolgreich erstellt."
    else
      render :new
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to [:admin, :users], :notice => "Benutzer erfolgreich gespeichert." }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to [:admin, :users]
  end

  private

  def user_params
    params.require(:user).permit :city, :clothing_leather, :clothing_textile, :country, :country_code, :date_of_birth, :description, :distance, :distance_per_year, :drive_belt, :drive_cardan, :drive_chain, :driving_description, :driving_style_cruise, :driving_style_fast, :driving_style_offroad, :driving_style_race, :driving_style_speeder, :driving_style_tour, :email, :failed_attempts, :favorite_amount_of_cylinders, :favorite_vendor, :favourite_areas, :favourite_experience, :gender, :http, :licence_date, :locked_at, :name, :password, :password_confirmation, :points, :remember_me, :sign_in_count, :terms_of_service, :provider, :zip
  end

end
