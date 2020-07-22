class ContentField::Base

  include Mongoid::Document

  include Concerns::Customer::Database

  embedded_in :content_type
  embedded_in :global_content_type

  field :description,      type: String
  field :field_id,         type: String # title, description, category_name
  field :is_display_field, type: Boolean, default: false
  field :localized,        type: Boolean, default: false
  field :name,             type: String # Title, Description, Category name
  field :required,         type: Boolean, default: false
  field :validations,      type: Array  # [ { "range": { "min": 1, "max": 10 } } ]

  scope :assets, -> { where(:_type.in => [ ContentField::Document, ContentField::Image, ContentField::Video ]) }

  validates :field_id, presence: true, uniqueness: true
  validates :name,     presence: true, uniqueness: true

  before_validation :generate_field_id
  before_validation :generate_name

  def allowed_field_ids
    [self.field_id]
  end

  def before_validation_callback
    Proc.new do |content|
    end
  end

  def customer
    content_type&.customer || global_content_type&.customer
  end

  # initializes a field in content object
  # overwrite this method in other ContentField-Classes
  def initialize_callback
    Proc.new do |content|
      unless content.respond_to?(self.field_id)
        content[self.field_id.to_sym] ||= nil
      end
    end
  end

  def to_s
    self.name
  end

  def validation_callback
    Proc.new do |content|
      if self.required?
        # content.errors.add_on_blank self.field_id
        content.errors.add(self.field_id, :blank) if content.send(self.field_id).blank?
      end
    end
  end

  private

  # before_validation
  def generate_field_id
    if self.field_id.blank?
      str = ActiveSupport::Inflector.transliterate(self.name).downcase
    else
      str = self.field_id
    end
    self.field_id = str.gsub(" ", "_").try(:underscore).try(:camelcase, :lower)
    if self.respond_to?(:has_many) and self.has_many
      self.field_id = self.field_id.pluralize
    end
  end

  # before_validation
  def generate_name
    if self.name.blank? and self.field_id.present?
      self.name = self.field_id.underscore.humanize
    end
  end

end
