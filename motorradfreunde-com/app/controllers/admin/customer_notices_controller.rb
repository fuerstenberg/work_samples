class Admin::CustomerNoticesController < Admin::ApplicationController

  before_filter :find_object

  def new
    @customer_notice = @customer.customer_notices.build
  end

  def create
    @customer_notice = @customer.customer_notices.build customer_notice_params
    if @customer_notice.save
      redirect_to [:admin, @customer]
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @customer_notice.update_attributes(customer_notice_params)
      redirect_to [:admin, @customer]
    else
      render :new
    end
  end

  def destroy
    @customer_notice.destroy
    redirect_to [:admin, @customer]
  end

  private

  def find_object
    @customer = Customer.find params[:customer_id]
    @customer_notice = @customer.customer_notices.find params[:id] if params[:id]
  end

  def customer_notice_params
    params.require(:customer_notice).permit :body, :customer_id
  end

end
