class ContentField::DocumentsController < ContentField::BaseController

  private

  def build(params = nil)
    @content_type.content_field_documents.build params
  end

end
