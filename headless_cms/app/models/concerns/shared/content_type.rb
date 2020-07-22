module Concerns::Shared::ContentType

  extend ActiveSupport::Concern

  included do
    embeds_many :content_fields,            class_name: "ContentField::Base",      store_as: 'content_fields'
    embeds_many :content_field_addresses,   class_name: "ContentField::Address",   store_as: 'content_fields'
    embeds_many :content_field_booleans,    class_name: "ContentField::Boolean",   store_as: 'content_fields'
    embeds_many :content_field_decimals,    class_name: "ContentField::Decimal",   store_as: 'content_fields'
    embeds_many :content_field_documents,   class_name: "ContentField::Document",  store_as: 'content_fields'
    embeds_many :content_field_images,      class_name: "ContentField::Image",     store_as: 'content_fields'
    embeds_many :content_field_integers,    class_name: "ContentField::Integer",   store_as: 'content_fields'
    embeds_many :content_field_long_texts,  class_name: "ContentField::LongText",  store_as: 'content_fields'
    embeds_many :content_field_short_texts, class_name: "ContentField::ShortText", store_as: 'content_fields'
    embeds_many :content_field_times,       class_name: "ContentField::Time",      store_as: 'content_fields'
    embeds_many :content_field_videos,      class_name: "ContentField::Video",     store_as: 'content_fields'

    field :auto_publish,  type: Boolean, default: false
    field :name,          type: String
    field :description,   type: String
    field :type,          type: String

    validates :name, presence: true, uniqueness: true
    validates :type, presence: true, uniqueness: true

    before_validation :generate_type
  end

  def allowed_field_ids
    self.content_fields.map{ |content_field|
      content_field.allowed_field_ids
    }.flatten.map &:to_sym
  end

  def allowed_field_ids_without_nested_fields
    allowed_field_ids.select{ |field| !field.to_s.include?('_attributes') }
  end

  def allowed_image_fields
    content_fields.select{ |content_field|
      content_field.is_a?(ContentField::Image)
    }.map{|content_field| content_field.allowed_fields }.flatten
  end

  def display_fields
    content_fields.select(&:is_display_field?).map(&:field_id)
  end

  def to_s
    self.name
  end

  private

  # before_validation
  def generate_type
    if self.type.blank? and self.name
      self.type = self.name.parameterize.underscore
    end
  end

end
