class Api::Customers::V1::ImagesController < Api::Customers::V1::ApplicationController

  before_action :set_content, only: [:index, :show, :create, :destroy, :destroy_all]
  before_action :set_image, only: [:show, :destroy]

  # returns ids only
  def index
    render json: @content.all_images
  end

  def show
    render json: @image
  end

  def create
    @content.allowed_image_fields.each do |allowed_image_field|
      field_id = allowed_image_field[:field_id]
      image_attributes = "#{field_id}_attributes"
      next if params[image_attributes].blank?
      if allowed_image_field[:has_many]
        @image = @content.send( field_id ).build
      else
        @image = @content.send "build_#{field_id}"
      end

      if params[image_attributes] and params[image_attributes][:file]
        @image.file = params[image_attributes][:file]
      elsif params[image_attributes] and params[image_attributes][:file_url]
        @image.remote_file_url = params[image_attributes][:file_url]
      end
    end

    if @image.save
      render json: @image, status: :ok, location: [:api, :customers, :v1, @content, @image]
    else
      logger.error "------ Unprocessable Entity:"
      logger.error @image.inspect
      logger.error @image.errors.inspect
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @image.destroy
    render json: @image, status: :ok
  end

  def destroy_all
    @content.allowed_image_fields.each do |allowed_image_field|
      field_id = allowed_image_field[:field_id]
      if allowed_image_field[:has_many]
        @content.send( field_id )&.destroy_all
      else
        @content.send( field_id )&.destroy
      end
    end
    render json: {}, status: :ok
  end

  private

  def set_content
    @content = @customer.contents.or(
      { id:         params[:content_id] },
      { foreign_id: params[:content_id] }
    ).first
    if @content
      logger.info "-- Content: #{@content.id} #{@content}"
    else
      return head :not_found
    end
  end

  def set_image
    @image = @content.find_image params[:id]
  end

  # # Never trust parameters from the scary internet, only allow the white list through.
  def image_params
    params.require(*@content.allowed_image_field_ids).permit!
  end

end
