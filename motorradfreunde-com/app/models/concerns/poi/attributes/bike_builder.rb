module Concerns::Poi::Attributes::BikeBuilder

  extend ActiveSupport::Concern

  included do
    field :is_bike_builder,            type: Boolean, default: false
    field :motorradbauer_beschreibung, type: String,  default: ''
  end

  module ClassMethods
    def bike_builder_attribute_names
      ['is_bike_builder'] + attributes_with_prefix('motorradbauer')
    end
  end

end
