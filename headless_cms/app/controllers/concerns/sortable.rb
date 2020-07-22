module Concerns::Sortable
  extend ActiveSupport::Concern

  included do
  end

  def sort
    @customer.contents.sort_by_ids params[:sortable_ids]
    head :ok
  end

end
