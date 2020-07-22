module Concerns::ContentField::Nested

  extend ActiveSupport::Concern

  included do
    field :has_many, type: Boolean, default: false
  end

  def allowed_field_ids
    ["#{self.field_id}_attributes"]
  end

  def allowed_fields
    {
      field_id: field_id,
      has_many: has_many?,
      nested:   true,
    }
  end

  def has_one?
    !self.has_many?
  end
  alias_method :has_one, :has_one?

  def initialize_callback
    Proc.new do |content|
      # TODO: TESTS
      # nested_reject_if_for_addresses
      # nested_reject_if_for_images
      reject_if = "nested_reject_if_for_#{self.class.to_s.demodulize.downcase}"
      if self.has_many?
        content.class_eval <<-HAS_MANY_IMAGES, __FILE__, __LINE__ + 1
          embeds_many :#{self.field_id}, as: :#{self.polymorphic_association_name}, class_name: "#{self.class.to_s.demodulize}", cascade_callbacks: true
          accepts_nested_attributes_for :#{self.field_id},
            allow_destroy: true,
            reject_if: :#{reject_if.pluralize}
        HAS_MANY_IMAGES
      else
        content.class_eval <<-HAS_ONE_IMAGE, __FILE__, __LINE__ + 1
          embeds_one :#{self.field_id}, as: :#{self.polymorphic_association_name}, class_name: "#{self.class.to_s.demodulize}", cascade_callbacks: true
          accepts_nested_attributes_for :#{self.field_id},
            allow_destroy: true,
            reject_if: :#{reject_if}
        HAS_ONE_IMAGE
      end
    end
  end

  private

  # before_validation in base class
  def generate_field_id
    super
    if self.has_many? and self.field_id
      self.field_id = self.field_id.pluralize
    end
  end

end
