module ContentFieldsHelper

  def content_field_form_url(content_type, content_field)
    if content_type.is_a?(GlobalContentType)
      [content_type, content_field]
    else
      [content_type.customer, content_type, content_field]
    end
  end

end
