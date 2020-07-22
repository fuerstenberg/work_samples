class SearchesController < ApplicationController

  skip_before_action :authenticate_user!

  def index
    @query = params[:search][:query] if params[:search]
    @search_results = Search.full_text_search @query
  end

end
