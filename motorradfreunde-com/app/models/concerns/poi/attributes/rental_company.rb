module Concerns::Poi::Attributes::RentalCompany

  extend ActiveSupport::Concern

  included do
    field :is_rental_company,       type: Boolean, default: false
    field :vermietung_beschreibung, type: String,  default: ''
  end

  module ClassMethods
    def rental_company_attribute_names
      ['is_rental_company'] + attributes_with_prefix('vermietung')
    end
  end

end
