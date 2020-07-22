module Concerns::SetObjects

  extend ActiveSupport::Concern

  included do
    before_filter :set_article
    before_filter :set_bike
    before_filter :set_event
    before_filter :set_forum
    before_filter :set_poi
    before_filter :set_user
  end

  private

  def set_article
    @article = ::Article.find_by(slug: params[:article_id]) if params[:article_id]
  rescue Mongoid::Errors::DocumentNotFound => e
    render nothing: true, status: 301
  end

  def set_bike
    @bike = ::Bike.find_by(slug: params[:bike_id]) if params[:bike_id]
  rescue Mongoid::Errors::DocumentNotFound => e
    render nothing: true, status: 301
  end

  def set_event
    @event = ::Event.find_by(slug: params[:event_id]) if params[:event_id]
  rescue Mongoid::Errors::DocumentNotFound => e
    render nothing: true, status: 301
  end

  def set_forum
    @forum = ::Forum.find_by(slug: params[:forum_id]) if params[:forum_id]
  rescue Mongoid::Errors::DocumentNotFound => e
    render nothing: true, status: 301
  end

  def set_poi
    @poi = ::Poi.find_by(slug: params[:poi_id]) if params[:poi_id]
  rescue Mongoid::Errors::DocumentNotFound => e
    render nothing: true, status: 301
  end

  def set_user
    @user = ::User.find_by(slug: params[:user_id]) if params[:user_id]
  rescue Mongoid::Errors::DocumentNotFound => e
    render nothing: true, status: 301
  end

end
