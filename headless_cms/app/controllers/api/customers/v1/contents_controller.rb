class Api::Customers::V1::ContentsController < Api::Customers::V1::ApplicationController

  before_action :set_content, only: [:show, :update, :destroy]
  before_action :set_content_type, only: [:index, :create]

  # returns ids only
  def index
    @contents = Current.customer.contents.ordered
    if @content_type
      @contents = @contents.where(content_type_id: @content_type.id)
    end
    render json: @contents, each_serializer: ContentsSerializer
  end

  def show
    render json: @content
  end

  def create
    @content = Current.customer.contents.build
    @content.content_type = @content_type
    @content.attributes = content_params
    if @content.save
      render json: @content, status: :ok, location: [:api, :customers, :v1, @content]
    else
      render json: @content.errors, status: :unprocessable_entity
    end
  end

  def update
    if @content.update_attributes(content_params)
      render json: @content, status: :ok, location: [:api, :customers, :v1, @content]
    else
      render json: @content.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @content.destroy
    render json: @content, status: :ok
  end

  private

  def set_content_type
    @content_type = ContentType.or(
      { id: params[:content_type_id] },
      { type: params[:content_type_id] }
    ).first
  end

  def set_content
    @content = Current.customer.contents.or(
      { id:         params[:id] },
      { foreign_id: params[:id] }
    ).first
    unless @content
      return head :not_found
    end
  end

  # # Never trust parameters from the scary internet, only allow the white list through.
  def content_params
    content = params.require(:content).permit!
    content.delete :customer
    content
  end

end
