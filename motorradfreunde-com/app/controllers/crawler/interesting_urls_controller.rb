class Crawler::InterestingUrlsController < ApplicationController

  def create
    InterestingUrl.create params[:interesting_url].permit!
    redirect_to :back
  end

end
