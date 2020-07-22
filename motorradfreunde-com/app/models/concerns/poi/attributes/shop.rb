module Concerns::Poi::Attributes::Shop

  extend ActiveSupport::Concern

  included do
    field :is_online_shop,          type: Boolean, default: false
    field :is_shop,                 type: Boolean, default: false
    field :shop_beschreibung,       type: String,  default: ''
    field :shop_bekleidung,         type: Boolean, default: false
    field :shop_bekleidung_helme,   type: Boolean, default: false
    field :shop_bekleidung_leder,   type: Boolean, default: false
    field :shop_bekleidung_textil,  type: Boolean, default: false
    field :shop_finanzierung,       type: Boolean, default: false
    field :shop_geschenkgutscheine, type: Boolean, default: false
    field :shop_zubehoer,           type: Boolean, default: false
  end

  module ClassMethods
    def shop_attribute_names
      ['is_shop'] + attributes_with_prefix('shop')
    end
  end

end
