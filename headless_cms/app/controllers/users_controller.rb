class UsersController < ApplicationController

  before_action :find_user

  def index
    authorize! :read, User
    @users = @customer ? @customer.users.sort_by(&:name) : User.order('name asc').all
  end

  def show
    authorize! :read, @user
  end

  def new
    authorize! :create, User
    @user = User.new
  end

  def create
    authorize! :create, User
    @user = User.find_or_initialize_by email: user_params[:email]
    if @user.new_record?
      @user.attributes = user_params
      if @user.save
        redirect_to @user, notice: I18n.t('notice.user.created')
      else
        render :new
      end
    elsif @user.persisted?
      @user.becomes_editor_of! customer: Current.customer if !@user.has_role_for?(customer: Current.customer) && !@user.god?
      redirect_to @user
    end
  end

  def edit
    authorize! :update, @user
  end

  def update
    authorize! :update, @user
    if @user.update_attributes(user_params)
      redirect_to @user, notice: I18n.t('notice.user.updated')
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @user
    @user.destroy
    redirect_to :users, notice: I18n.t('notice.user.deleted')
  end

  private

  def find_user
    @user = User.find params[:id] if params[:id]
  end

  def user_params
    user_params = params.require(:user).permit!
    user_params.delete :password              if user_params[:password].blank?
    user_params.delete :password_confirmation if user_params[:password_confirmation].blank?
    user_params
  end

end
