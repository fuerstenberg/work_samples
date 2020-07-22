class ContentField::IntegersController < ContentField::BaseController

  private

  def build(params = nil)
    @content_type.content_field_integers.build params
  end

end
