class ContentField::ImagesController < ContentField::BaseController

  private

  def build(params = nil)
    @content_type.content_field_images.build params
  end

end
