class ContentField::ShortTextsController < ContentField::BaseController

  private

  def build(params = nil)
    @content_type.content_field_short_texts.build params
  end

end
