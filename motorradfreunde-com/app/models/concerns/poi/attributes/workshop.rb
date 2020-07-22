module Concerns::Poi::Attributes::Workshop

  extend ActiveSupport::Concern

  included do
    field :is_workshop,                     type: Boolean, default: false
    field :werkstatt_beschreibung,          type: String,  default: ''
    field :werkstatt_austauschmotorraeder,  type: Boolean, default: false
    field :werkstatt_ist_typenoffen,        type: Boolean, default: false
    field :werkstatt_marken,                type: String,  default: ''
    field :werkstatt_hol_bring,     type: Boolean, default: false
    field :werkstatt_hu,            type: Boolean, default: false
    field :werkstatt_inspektionen,  type: Boolean, default: false
    field :werkstatt_pannenservice, type: Boolean, default: false
    field :werkstatt_reifen,        type: Boolean, default: false
    field :werkstatt_reparatur,     type: Boolean, default: false
    field :werkstatt_stellplaetze,   type: Boolean, default: false
    field :werkstatt_tuev,          type: Boolean, default: false
    field :werkstatt_umbauten,      type: Boolean, default: false
  end

  module ClassMethods
    def workshop_attribute_names
      ['is_workshop'] + attributes_with_prefix('werkstatt')
    end
  end

end
