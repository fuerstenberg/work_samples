class ContentField::BaseController < ApplicationController

  before_action :set_content_type, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :set_content_field, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @content_field = build
  end

  def edit
  end

  def create
    @content_field = build(content_field_params)
    if @content_field.save
      redirect_to get_content_type_url, notice: 'Content type was successfully created.'
    else
      render :new
    end
  end

  def update
    if @content_field.update_attributes(content_field_params)
      redirect_to get_content_type_url, notice: 'Content type was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @content_field.destroy
    redirect_to get_content_type_url, notice: 'Content type was successfully destroyed.'
  end

  private

  def get_content_type_url
    if @content_type.is_a?(GlobalContentType)
      url_for @content_type
    else
      url_for [@content_type.customer, @content_type]
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_content_type
    if params[:global_content_type_id]
      @content_type = GlobalContentType.find params[:global_content_type_id]
    else
      @content_type = ContentType.find params[:content_type_id]
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_content_field
    @content_field = @content_type.content_fields.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def content_field_params
    params.require(:content_field).permit!
  end

end
