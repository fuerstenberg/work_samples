module Concerns::Searchable
  extend ActiveSupport::Concern

  def search
    if params[:q].present?
      @contents = @customer.contents.full_text_search(params[:q]).page params[:page]
      render :index
    else
      redirect_to request.path.gsub('/search', '')
    end
  end

end
