class RolesController < ApplicationController

  before_action :set_user
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  before_action :set_customer

  def new
    authorize! :create, Role
    @role = @user.roles.build type: :editor
    render template: 'users/show'
  end

  def create
    @role = @user.roles.build role_params
    authorize! :create, @role
    if @role.save
      redirect_to @user
    else
      render template: 'users/show'
    end
  end

  def edit
    authorize! :update, @role
    render template: 'users/show'
  end

  def update
    @role.type = params[:role][:type]
    authorize! :update, @role
    if @role.save
      redirect_to @user
    else
      render template: 'users/show'
    end
  end

  def destroy
    authorize! :destroy, @role
    @role.destroy
    redirect_to @user
  end

  private

  def role_params
    params.require(:role).permit :type, :customer_id
  end

  def set_customer
    @customer = Customer.find params[:customer_id] if params[:customer_id]
  end

  def set_role
    @role = @user.roles.find params[:id]
  end

  def set_user
    # @user = User.find_by email: params[:user][:email] if params[:user][:email]
    @user = User.find params[:user_id] if params[:user_id]
  end

end
