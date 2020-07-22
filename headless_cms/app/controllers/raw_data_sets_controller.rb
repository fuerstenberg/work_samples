class RawDataSetsController < ApplicationController

  before_action :set_content
  before_action :set_raw_data_set, only: [:show]

  def index
    authorize! :read, RawDataSet
    @raw_data_sets = @content.raw_data_sets.order(created_at: :desc).limit 40
  end

  def show
    authorize! :read, @raw_data_set
  end

  private

  def set_content
    @content = @customer.contents.find params[:content_id]
  end

  def set_raw_data_set
    @raw_data_set = @content.raw_data_sets.find params[:id]
  end

end
