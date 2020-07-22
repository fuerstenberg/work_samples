module Concerns::Poi::Attributes::TourOperator

  extend ActiveSupport::Concern

  included do
    field :is_tour_operator,           type: Boolean, default: false
    field :reiseanbieter_beschreibung, type: String,  default: ''
    field :reiseanbieter_touren,       type: Boolean, default: false
    field :reiseanbieter_reisen,       type: Boolean, default: false
  end

  module ClassMethods
    def tour_operator_attribute_names
      ['is_tour_operator'] + attributes_with_prefix('reiseanbieter')
    end
  end

end
