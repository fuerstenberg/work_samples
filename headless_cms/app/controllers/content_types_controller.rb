class ContentTypesController < ApplicationController

  before_action :set_content_type,        only: [:show, :edit, :update, :destroy]
  before_action :set_global_content_type, only: [:create]

  def index
    @content_types = Current.customer.content_types.order("name asc").all
  end

  def show
    authorize! :read, @content_type
  end

  def new
    authorize! :create, ContentType
    @content_type = Current.customer.content_types.build
  end

  def edit
    authorize! :update, @content_type
  end

  def create
    authorize! :create, ContentType
    if @global_content_type
      @content_type = @global_content_type.build_content_type_for_customer
    else
      @content_type = Current.customer.content_types.build(content_type_params)
    end
    if @content_type.save
      redirect_to [Current.customer, @content_type], notice: 'Content type was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize! :update, @content_type
    if @content_type.update_attributes(content_type_params)
      redirect_to [Current.customer, @content_type], notice: 'Content type was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @content_type
    @content_type.destroy
    redirect_to [Current.customer, :content_types], notice: 'Content type was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_content_type
    @content_type = ContentType.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def content_type_params
    params.require(:content_type).permit!
  end

  def set_global_content_type
    @global_content_type = GlobalContentType.find params[:global_content_type_id] if params[:global_content_type_id]
  end

end
