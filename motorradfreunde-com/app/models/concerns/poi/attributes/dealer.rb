module Concerns::Poi::Attributes::Dealer

  extend ActiveSupport::Concern

  included do
    field :is_dealer,             type: Boolean, default: false
    field :haendler_beschreibung, type: String,  default: ''
    field :haendler_finanzierung, type: Boolean, default: false
    field :haendler_marken,       type: String,  default: ''
  end

  module ClassMethods
    def dealer_attribute_names
      ['is_dealer'] + attributes_with_prefix('haendler')
    end
  end

end
