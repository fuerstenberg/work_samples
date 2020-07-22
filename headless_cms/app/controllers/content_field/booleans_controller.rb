class ContentField::BooleansController < ContentField::BaseController

  private

  def build(params = nil)
    @content_type.content_field_booleans.build params
  end

end
