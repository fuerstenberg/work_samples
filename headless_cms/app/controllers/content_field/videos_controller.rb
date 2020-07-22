class ContentField::VideosController < ContentField::BaseController

  private

  def build(params = nil)
    @content_type.content_field_videos.build params
  end

end
