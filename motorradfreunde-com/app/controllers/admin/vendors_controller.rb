class Admin::VendorsController < Admin::ApplicationController

  def index
    @vendors = Vendor.order :name
  end

  def show
    @vendor = Vendor.find params[:id]
  end

  def new
    @vendor = Vendor.new
  end

  def create
    @vendor = Vendor.new vendor_params
    if @vendor.save
      redirect_to [:admin, @vendor]
    else
      render :new
    end
  end

  def edit
    @vendor = Vendor.new
  end

  def update
    @vendor = Vendor.find params[:id]
    if @vendor.update_attributes(vendor_params)
      redirect_to [:admin, @vendor]
    else
      render :new
    end
  end

  def destroy
    @vendor = Vendor.find params[:id]
    @vendor.destroy
    redirect_to [:admin, :vendors]
  end

  private

  def vendor_params
    # params.require(:vendor).permit :vendor_name, :user_id, :model, :ccm, :hp, :year_of_manufacture, :color, :description, :category, :property, :permalink, :vendor_bike_id, :poi_id
    params.require(:vendor).permit!
  end

end
