module Concerns::Content::ContentType

  def content_type=(value)
    super value
    initialize_missing_fields
  end
  # alias_method_chain :content_type=, :initialize_fields

end
