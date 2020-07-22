class ContentField::DecimalsController < ContentField::BaseController

  private

  def build(params = nil)
    @content_type.content_field_decimals.build params
  end

end
