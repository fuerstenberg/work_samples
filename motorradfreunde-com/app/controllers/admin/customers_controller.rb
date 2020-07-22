class Admin::CustomersController < Admin::ApplicationController

  def index
    @customers = Customer.order([:url, :name, :country, :zip]).page params[:page]
  end

  def show
    @customer = Customer.find params[:id]
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new customer_params
    if @customer.save
      redirect_to request.referrer.ends_with?('admin/customers') ? [:admin, :customers] : [:admin, @customer], notice: "Successfully saved."
    else
      if request.referrer.ends_with?('admin/customers')
        redirect_to [:admin, :customers], alert: "Not saved!"
      else
        render :new
      end
    end
  end

  def edit
    @customer = Customer.find params[:id]
  end

  def update
    @customer = Customer.find params[:id]
    if @customer.update_attributes(customer_params)
      redirect_to [:admin, @customer]
    else
      render :edit
    end
  end

  def destroy
    @customer = Customer.find params[:id]
    @customer.destroy
    redirect_to [:admin, :customers]
  end

  private

  def customer_params
    params.require(:customer).permit :city, :contact, :country, :description, :email, :fax, :name, :phone, :street, :url, :zip
  end

end
