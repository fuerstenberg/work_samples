class ContentField::LongTextsController < ContentField::BaseController

  private

  def build(params = nil)
    @content_type.content_field_long_texts.build params
  end

end
