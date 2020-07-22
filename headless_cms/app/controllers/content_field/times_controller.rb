class ContentField::TimesController < ContentField::BaseController

  private

  def build(params = nil)
    @content_type.content_field_times.build params
  end

end
