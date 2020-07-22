class Admin::PoisController < Admin::ApplicationController

  before_filter :find_poi

  def index
    @pois = Poi
    @pois = @pois.tagged_with(Tag.find(params[:tag]).to_s, all: true) if params[:tag].present?
    @pois = @pois.order(params[:order] || 'updated_at asc').page params[:page]
  end

  def show
  end

  def search
    # @search = Poi.search params[:query]
    respond_to do |format|
      format.json { render json: [].to_json }
    end
  end

  def new
    @poi = @customer.pois.build
    3.times { @poi.photos.build }
  end

  def create
    @poi = @customer.pois.build poi_params
    if @poi.save
      redirect_to [:admin, @poi], notice: "POI was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if params[:version_id]
      @poi = @poi.versions.find(params[:version_id]).reify
      @poi.save
      redirect_to [:admin, @poi], notice: "POI was successfully updated."
    elsif @poi.update_attributes(poi_params)
      redirect_to [:admin, @poi], notice: "POI was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @poi.destroy
    redirect_to [:admin, :pois]
  end

  private

  def find_poi
    @customer = Customer.find params[:customer_id] if params[:customer_id]
    @poi = Poi.find params[:id] if params[:id]
  end

  def poi_params
    params.require(:poi).permit!
  end

end
