class ContentListsController < ApplicationController
  before_action :set_content_list, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @content_lists = Current.customer.content_lists.all
    respond_with Current.customer, @content_lists
  end

  def show
    respond_with Current.customer, @content_list
  end

  def new
    @content_list = Current.customer.content_lists.build
    respond_with Current.customer, @content_list
  end

  def edit
  end

  def create
    @content_list = Current.customer.content_lists.build(content_list_params)
    @content_list.save
    respond_with Current.customer, @content_list
  end

  def update
    @content_list.update(content_list_params)
    respond_with Current.customer, @content_list
  end

  def destroy
    @content_list.destroy
    respond_with Current.customer, @content_list
  end

  private

  def set_content_list
    @content_list = Current.customer.content_lists.find(params[:id])
  end

  def content_list_params
    params.require(:content_list).permit(:name)
  end
end
