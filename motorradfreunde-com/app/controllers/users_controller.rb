class UsersController < ApplicationController

  layout 'fullscreen_formular', only: [:edit, :update, :cancel, :password_edit, :password_update]

  skip_before_action :authenticate_user!, only: [:index]

  before_filter :set_user, only: [:show, :dashboard, :edit, :update, :destroy]

  after_filter :count_impression, only: :show

  has_scope :order, only: :index do |controller, scope, value|
    values = ['impressions_count desc', 'images_count desc', 'created_at desc']
    if values.include?(value)
      scope.order value
    else
      scope.order(created_at: :desc)
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
    @users = apply_scopes(User).order_by_has_images.recent
    if params[:query]
      @users = @users.search params[:query], page: params[:page]
    else
      # TODO: order by images count desc
      @users = @users.page(params[:page]).per 30
    end
  end

  def dashboard
    authorize! :read, @user
    @activities = Kaminari.paginate_array((@user || current_user).public_activities).page params[:page]
  end

  def show
    authorize! :read, @user
    render :show
  end

  def edit
    authorize! :update, @user
  end

  def update
    authorize! :update, @user
    updated = if params[:user] && params[:user][:password].blank?
      current_user.update_without_password(user_params)
    else
      current_user.update_attributes(user_params)
    end
    if updated
      redirect_to current_user, notice: I18n.t("controller.accounts.update.notice")
    else
      render :edit
    end
  end

  def password_edit
    @user = current_user
  end

  def password_update
    if current_user.valid_password?(params[:user][:old_password]) and current_user.update(password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
      redirect_to current_user, notice: 'I18n.t("controller.users.password_update.notice")'
    else
      render :password_edit
    end
  end

  def cancel
    authorize! :destroy, current_user
  end

  def destroy
    authorize! :destroy, @user
    @user.destroy
    if @user == current_user and current_user_session
      current_user_session.destroy
    end
    redirect_to root_url, alert: I18n.t("controller.accounts.destroy.alert")
  end

  private

  def set_user
    @user = User.find_by slug: params[:id]
    save_last_visited_user @user
  end

  def user_params
    params.require(:user).permit([:email, :name, :password, :password_confirmation, :terms_of_service] + User.detail_attributes)
  end

end
