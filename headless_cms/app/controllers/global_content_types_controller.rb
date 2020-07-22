class GlobalContentTypesController < ApplicationController

  before_action :set_global_content_type, only: [:show, :edit, :update, :destroy]

  def index
    authorize! :read, GlobalContentType
    @global_content_types = GlobalContentType.order("name asc").all
  end

  def show
    authorize! :read, @global_content_type
  end

  def new
    authorize! :create, GlobalContentType
    @global_content_type = GlobalContentType.new
  end

  def edit
    authorize! :update, @global_content_type
  end

  def create
    authorize! :create, GlobalContentType
    @global_content_type = GlobalContentType.new(global_content_type_params)
    if @global_content_type.save
      redirect_to @global_content_type, notice: 'Global content type was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize! :update, @global_content_type
    if @global_content_type.update(global_content_type_params)
      redirect_to @global_content_type, notice: 'Global content type was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @global_content_type
    @global_content_type.destroy
    redirect_to :global_content_types, notice: 'Global content type was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_global_content_type
    @global_content_type = GlobalContentType.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def global_content_type_params
    params.require(:global_content_type).permit!
  end

end
