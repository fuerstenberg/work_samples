module Concerns::Poi::Attributes::Vendor

  extend ActiveSupport::Concern

  included do
    has_many :bikes, foreign_key: :poi_id

    field :bikes_count,             type: Fixnum,  default: 0
    field :is_vendor,               type: Boolean, default: false
    field :hersteller_beschreibung, type: String,  default: ''

    validates :name, uniqueness: { if: :is_vendor? }, presence: true

    scope :vendors, -> { where(is_vendor: true) }
  end

  module ClassMethods
    def vendor_attribute_names
      ['is_vendor'] + attributes_with_prefix('hersteller')
    end
  end

end
