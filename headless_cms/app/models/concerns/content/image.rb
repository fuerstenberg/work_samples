module Concerns::Content::Image

  extend ActiveSupport::Concern

  included do
    delegate :allowed_image_fields, to: :content_type
  end

  def all_images
    images = self.content_type.content_fields.where(_type: ContentField::Image).inject([]) do |images, content_field|
      images << self.send(content_field.field_id)
      images
    end
    images.flatten.compact
  end

  def build_image_content_fields
    return unless self.content_type
    self.content_type.content_fields.where(_type: ContentField::Image).each do |content_field|
      if content_field.has_many?
        self.send(content_field.field_id).build
      elsif content_field.has_one? and self.send(content_field.field_id).blank?
        self.send("build_#{content_field.field_id}")
      end
    end
  end

  def find_image(id)
    self.all_images.detect do |image|
      image.id.to_s == id
    end
  end

  # TODO: TESTS
  def nested_reject_if_for_image(attributes)
    attributes['file'].blank? and attributes['remote_file_url'].blank? and not attributes['id']
  end

  # TODO: TESTS
  def nested_reject_if_for_images(attributes)
    attributes['file'].blank? and attributes['remote_file_url'].blank? and not attributes['_destroy']
  end

end
