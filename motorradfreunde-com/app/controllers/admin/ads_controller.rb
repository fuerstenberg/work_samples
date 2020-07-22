class Admin::AdsController < Admin::ApplicationController

  before_filter :find_objects

  def index
    @ads = Ad.order(target: :asc, active: :desc, position: :desc, title: :asc).load
  end

  def show
    @ad = Ad.find params[:id]
  end

  def new
    @ad = @customer.ads.build
  end

  def edit
    @ad = @customer.ads.find params[:id]
  end

  def create
    @ad = @customer.ads.build ad_params
    if @ad.save
      redirect_to [:admin, @customer, @ad], notice: 'Ad was successfully created.'
    else
      render :new
    end
  end

  def update
    @ad = @customer.ads.find params[:id]
    if @ad.update_attributes(ad_params)
      redirect_to :back, notice: 'Ad was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @ad = @customer.ads.find params[:id]
    @ad.destroy
    redirect_to [:admin, @customer]
  end

  private

  def find_objects
    @customer = Customer.find params[:customer_id] if params[:customer_id]
  end

  def ad_params
    params.require(:ad).permit :active, :position, :url, :description, :html, :javascript, :target, :title, :subtitle, :html_only, :displayed_url
  end

end
