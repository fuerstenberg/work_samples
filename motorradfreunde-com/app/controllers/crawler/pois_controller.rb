class Crawler::PoisController < ApplicationController

  layout "crawler"

  def index
  end

  def new
    if @interesting_url = InterestingUrl.find(params[:interesting_url_id])
      @interesting_url.try :touch, :checked_at
      @poi = Poi.where("http LIKE '%#{@interesting_url.host}%'").first || Poi.new(http: @interesting_url.url)
    else
      @poi = Poi.new
    end
    render :index
  end

  def create
    @poi = Poi.new poi_params
    if @poi.save
      redirect_to [:crawler, :pois]
    else
      render :index
    end
  end

  def edit
    @poi = Poi.find(params[:id])
    render :index
  end

  def update
    @poi = Poi.find(params[:id])
    # @poi.server_side_geocoding = false
    if @poi.update_attributes(poi_params)
      redirect_to [:crawler, :pois]
    else
      render :edit
    end
  end

  def destroy
    @poi = Poi.find(params[:id])
    if @poi
      @poi.destroy
    end
    redirect_to [:crawler, :pois]
  end

  private

  def poi_params
    params.require(:poi).permit!
  end

end
