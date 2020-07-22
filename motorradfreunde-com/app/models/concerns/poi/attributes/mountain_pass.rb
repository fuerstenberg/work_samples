module Concerns::Poi::Attributes::MountainPass

  extend ActiveSupport::Concern

  included do
    field :is_mountain_pass,  type: Boolean, default: false
    field :pass_beschreibung, type: String,  default: ''
  end

  module ClassMethods
    def mountain_pass_attribute_names
      ['is_mountain_pass'] + attributes_with_prefix('pass')
    end
  end

end
