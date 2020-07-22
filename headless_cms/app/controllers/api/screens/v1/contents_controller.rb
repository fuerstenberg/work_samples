class Api::Screens::V1::ContentsController < Api::Screens::V1::ApplicationController

  before_action :set_content_type, only: [:index]
  before_action :set_content,      only: [:show]

  def index
    @contents = @screen.customer.contents.ordered.released_for_screen(@screen)
    if @content_type
      @contents = @contents.where(content_type_id: @content_type.id)
    end
    render json: @contents, each_serializer: ContentsSerializer
  end

  def show
    render json: @content
  end

  private

  def set_content
    @content = @screen.customer.contents.or(
      { id:          params[:id] },
      { external_id: params[:id] },
      { foreign_id:  params[:id] },
      { internal_id: params[:id] },
      { openimmo_id: params[:id] }
    ).first
    unless @content
      return head :not_found
    end
  end

  def set_content_type
    @content_type = ContentType.or(
      { id: params[:content_type_id] },
      { type: params[:content_type_id] }
    ).first
  end

  def content_params
    params.require(:content).permit!
  end

end
