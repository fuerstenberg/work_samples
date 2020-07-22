class CustomersController < ApplicationController

  before_action :set_current_customer_by_id, only: [:show, :edit, :update, :destroy]

  def index
    @customers = Current.user.customers
    if !Current.user.god? && !Current.user.admin? && @customers.count == 1
      redirect_to @customers.first
    else
      render :index
    end
  end

  def show
  end

  def new
    authorize! :create, Customer
    @customer = Customer.new
  end

  def edit
    authorize! :update, Current.customer
  end

  def create
    authorize! :create, Customer
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer, notice: 'Customer was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize! :update, Current.customer
    if Current.customer.update(customer_params)
      redirect_to Current.customer, notice: 'Customer was successfully updated.'
    else
      render :edit
    end
  end

  # TODO: act as paranoid einbauen, damit customer nur als gelöscht markiert werden
  def destroy
    authorize! :destroy, Current.customer
    Current.customer.destroy
    redirect_to customers_url, notice: 'Customer was successfully destroyed.'
  rescue Mongoid::Errors::DeleteRestriction
    redirect_to Current.customer, alert: 'Customer has already screens, contents or content types.'
  end

  private

  def customer_params
    params.require(:customer).permit([:name, {address_attributes: [:id, :street, :zip, :city, :country]}, :logo, :logo_cache])
  end

end
