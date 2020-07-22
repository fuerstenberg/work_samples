module Concerns::Content::Document

  extend ActiveSupport::Concern

  included do
  end

  def all_documents
    documents = self.content_type.content_fields.where(_type: ContentField::Document).inject([]) do |documents, content_field|
      documents << self.send(content_field.field_id)
      documents
    end
    documents.flatten.compact
  end

  def build_document_content_fields
    return unless self.content_type
    self.content_type.content_fields.where(_type: ContentField::Document).each do |content_field|
      if content_field.has_many?
        self.send(content_field.field_id).build
      elsif content_field.has_one? and self.send(content_field.field_id).blank?
        self.send("build_#{content_field.field_id}")
      end
    end
  end

  def find_document(id)
    self.all_documents.detect do |document|
      document.id.to_s == id
    end
  end

  # TODO: TESTS
  def nested_reject_if_for_document(attributes)
    attributes['file'].blank? and attributes['remote_file_url'].blank? and not attributes['id']
  end

  # TODO: TESTS
  def nested_reject_if_for_documents(attributes)
    attributes['file'].blank? and attributes['remote_file_url'].blank? and not attributes['_destroy']
  end

end
