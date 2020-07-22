class ContentsController < ApplicationController

  before_action :set_content, only: [:show, :edit, :update, :destroy]
  before_action :set_content_type, only: [:new, :create, :edit, :update]

  include Concerns::Releasable
  include Concerns::Searchable
  include Concerns::Sortable

  def index
    @contents = Current.customer.contents.ordered.page params[:page]
  end

  def show
    authorize! :read, @content
  end

  def new
    # initializes dynamic fields with default values, see content_type_with_initialize_fields=(value) in content.rb
    @content = Current.customer.contents.build content_type: @content_type
    authorize! :create, @content
    @content.build_address_content_fields
    @content.build_document_content_fields
    @content.build_image_content_fields
    @content.build_video_content_fields
  end

  def edit
    # if you add a new content field to an existing content type,
    # the content becomes the new content field in the edit form
    authorize! :update, @content
    @content.build_address_content_fields
    @content.build_document_content_fields
    @content.build_image_content_fields
    @content.build_video_content_fields
  end

  def create
    @content = Current.customer.contents.build content_type: @content_type
    authorize! :create, @content
    @content.attributes = content_params
    if @content.save
      redirect_to [Current.customer, @content], notice: 'Content was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize! :update, @content
    if @content.update_attributes(content_params)
      redirect_to [Current.customer, @content], notice: 'Content was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @content
    @content.destroy
    redirect_to [Current.customer, :contents], notice: 'Content was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_content
    @content = Current.customer.contents.find(params[:id])
  end

  def set_content_type
    @content_type = ContentType.find(params[:content_type_id]) if params[:content_type_id]
    @content_type = ContentType.find(params[:content][:content_type_id]) if params[:content] and params[:content][:content_type_id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def content_params
    params.require(:content).permit!
  end

end
