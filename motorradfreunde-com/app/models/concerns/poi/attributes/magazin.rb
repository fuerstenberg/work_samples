module Concerns::Poi::Attributes::Magazin

  extend ActiveSupport::Concern

  included do
    field :is_magazin,           type: Boolean, default: false
    field :magazin_beschreibung, type: String,  default: ''
  end

  module ClassMethods
    def magazin_attribute_names
      ['is_magazin'] + attributes_with_prefix('magazin')
    end
  end

end
