module Concerns::Content::Address

  extend ActiveSupport::Concern

  included do
  end

  def build_address_content_fields
    return unless self.content_type
    self.content_type.content_fields.where(_type: ContentField::Address).each do |content_field|
      if content_field.has_many?
        self.send(content_field.field_id).build
      elsif content_field.has_one? and self.send(content_field.field_id).blank?
        self.send("build_#{content_field.field_id}")
      end
    end
  end

  def nested_reject_if_for_address(attributes)
    attributes['city'].blank? and not attributes['id']
  end

  def nested_reject_if_for_addresses(attributes)
    attributes['city'].blank? and not attributes['_destroy']
  end

end
