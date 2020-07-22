module Concerns::Releasable
  extend ActiveSupport::Concern

  included do
  end

  def releases
    set_content
    if request.get?
      render :releases
    else request.get?
      @content.releases_attributes = release_params[:releases_attributes].to_h
      @content.save validate: false
      redirect_to [@customer, @content], notice: 'Content was successfully released.'
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def release_params
    # params.require(:content).permit!(:releases_attributes)
    params.require(:content).permit(releases_attributes: [:screen_id, :_destroy, :id])
  end

end
