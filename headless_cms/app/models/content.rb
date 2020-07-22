class Content

  prepend Concerns::Content::ContentType

  include Mongoid::Document
  include Mongoid::Search
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  include Concerns::Content::Address
  include Concerns::Content::Asset
  include Concerns::Content::Document
  include Concerns::Content::Image
  include Concerns::Content::RawDataSets
  include Concerns::Content::Releases
  include Concerns::Content::Search
  include Concerns::Content::Sortable
  include Concerns::Content::Time
  include Concerns::Content::Video

  include Concerns::Customer::Database

  belongs_to :content_type
  belongs_to :customer

  field :_checksum,  type: String
  field :foreign_id, type: String

  delegate \
    :allowed_field_ids,
    :allowed_field_ids_without_nested_fields,
  to: :content_type, allow_nil: true

  after_initialize :initialize_missing_fields, if: :persisted?

  before_validation :remove_invalid_attributes
  before_validation :call_before_validation_callback

  validates :foreign_id, uniqueness: { scope: [:customer_id, :content_type_id] }, allow_blank: true

  validate :presence_of_customer
  validate :presence_of_content_type
  validate :call_validation_callback

  def initialize_missing_fields
    self.content_type.content_fields.all.each do |content_field|
      content_field.initialize_callback.call self
    end
  end

  def to_s
    if _name.present?
      _name
    else
      super
    end
  end

  def _name
    @_name ||= content_type.display_fields.map{ |content_field| self[content_field] }.join ' '
  end

  private

  # validate
  def presence_of_customer
    self.errors.add(:customer, :blank) if self.customer.blank?
  end

  # before_validation
  def remove_invalid_attributes
    allowed_attributes = ["_id", "foreign_id", "_checksum", "content_type", "content_type_id", "customer", "customer_id"]
    if self.content_type
      allowed_attributes += content_type.allowed_field_ids.flatten.map(&:to_s)
    end
    self.attributes.keys.map(&:to_s).each do |attribute|
      unless allowed_attributes.include?(attribute)
        self.attributes.delete attribute
        self.attributes.delete attribute.to_sym
      end
    end
  end

  # validate
  def presence_of_content_type
    self.errors.add(:content_type, :blank) if self.content_type.blank?
  end


  ## Callbacks

  # before_validation
  def call_before_validation_callback
    return if self.content_type.blank?
    (self.content_type.content_fields or []).each do |content_field|
      content_field.before_validation_callback.call self
    end
  end

  # validate
  def call_validation_callback
    return if self.content_type.blank?
    (self.content_type.content_fields or []).each do |content_field|
      content_field.validation_callback.call self
    end
  end

end
