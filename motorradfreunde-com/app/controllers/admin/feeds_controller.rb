class Admin::FeedsController < Admin::ApplicationController

  before_action :set_feed

  def index
    @feeds = Feed.order(title: :asc)
  end

  def show
  end

  def new
    @feed = Feed.new
  end

  def create
    @feed = Feed.new feed_params
    if @feed.save
      redirect_to [:admin, @feed]
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @feed.update_attributes(feed_params)
      redirect_to [:admin, @feed]
    else
      render :edit
    end
  end

  def import
    @feed.fetch_feed_items
    redirect_to :back
  end

  def destroy
    @feed.destroy
    redirect_to [:admin, :feeds]
  end

  private

  def set_feed
    @feed = Feed.find params[:id] if params[:id]
  end

  def feed_params
    params.require(:feed).permit :title, :feed_url, :url, :language, :image_url, :image_link, :image_title, :description, :copyright, :published_at, :build_at
  end

end
