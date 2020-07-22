module Concerns::Poi::Attributes::Hotel

  extend ActiveSupport::Concern

  included do
    field :is_hotel,                               type: Boolean, default: false
    field :hotel_beschreibung,                     type: String,  default: ''
    field :hotel_lage,                             type: String,  default: ''
    field :hotel_typ,                              type: String,  default: ''

    field :hotel_anzahl_sterne,                    type: Integer, default: 0
    field :hotel_anzahl_appartments,               type: Integer, default: 0
    field :hotel_anzahl_betten,                    type: Integer, default: 0
    field :hotel_anzahl_doppelzimmer,              type: Integer, default: 0
    field :hotel_anzahl_einzelzimmer,              type: Integer, default: 0
    field :hotel_anzahl_mehrbettzimmer,            type: Integer, default: 0
    field :hotel_anzahl_zimmer,                    type: Integer, default: 0

    field :hotel_ausstattung_aufenthaltsraum,      type: Boolean, default: false
    field :hotel_ausstattung_badestrand,           type: Boolean, default: false
    field :hotel_ausstattung_bar,                  type: Boolean, default: false
    field :hotel_ausstattung_garage_abschliessbar, type: Boolean, default: false
    field :hotel_ausstattung_garage_kostenlos,     type: Boolean, default: false
    field :hotel_ausstattung_garage_motorrad,      type: Boolean, default: false
    field :hotel_ausstattung_garage,               type: Boolean, default: false
    field :hotel_ausstattung_liegewiese,           type: Boolean, default: false
    field :hotel_ausstattung_lift_garage,          type: Boolean, default: false
    field :hotel_ausstattung_lift,                 type: Boolean, default: false
    field :hotel_ausstattung_motorradwaschplatz,   type: Boolean, default: false
    field :hotel_ausstattung_parkplatz_anhaenger,  type: Boolean, default: false
    field :hotel_ausstattung_parkplatz_ueberdacht, type: Boolean, default: false
    field :hotel_ausstattung_parkplatz,            type: Boolean, default: false
    field :hotel_ausstattung_pool,                 type: Boolean, default: false
    field :hotel_ausstattung_saal,                 type: Boolean, default: false
    field :hotel_ausstattung_sauna,                type: Boolean, default: false
    field :hotel_ausstattung_schrauberecke,        type: Boolean, default: false
    field :hotel_ausstattung_terrasse,             type: Boolean, default: false
    field :hotel_ausstattung_trockenraum,          type: Boolean, default: false
    field :hotel_ausstattung_werkzeug,             type: Boolean, default: false
    field :hotel_ausstattung_wlan_kostenlos,       type: Boolean, default: false
    field :hotel_ausstattung_wlan,                 type: Boolean, default: false
    field :hotel_essen_biergarten,                 type: Boolean, default: false
    field :hotel_essen_fruehstueck,                type: Boolean, default: false
    field :hotel_essen_fruehstuecksbuffet,         type: Boolean, default: false
    field :hotel_essen_grillplatz,                 type: Boolean, default: false
    field :hotel_essen_halbpension,                type: Boolean, default: false
    field :hotel_essen_lunchpaket,                 type: Boolean, default: false
    field :hotel_essen_restaurant,                 type: Boolean, default: false
    field :hotel_essen_vollpension,                type: Boolean, default: false
    field :hotel_service_chef_ist_biker,           type: Boolean, default: false
    field :hotel_service_gartennutzung,            type: Boolean, default: false
    field :hotel_service_tourenkarte,              type: Boolean, default: false
    field :hotel_service_tourentipps,              type: Boolean, default: false
    field :hotel_service_waesche,                  type: Boolean, default: false
    field :hotel_service_wellness,                 type: Boolean, default: false
    field :hotel_zimmer_badewanne,                 type: Boolean, default: false
    field :hotel_zimmer_balkon,                    type: Boolean, default: false
    field :hotel_zimmer_bettwaesche,               type: Boolean, default: false
    field :hotel_zimmer_dusche,                    type: Boolean, default: false
    field :hotel_zimmer_haartrockner,              type: Boolean, default: false
    field :hotel_zimmer_handtuecher,               type: Boolean, default: false
    field :hotel_zimmer_minibar,                   type: Boolean, default: false
    field :hotel_zimmer_nichtraucher,              type: Boolean, default: false
    field :hotel_zimmer_radio,                     type: Boolean, default: false
    field :hotel_zimmer_terrasse,                  type: Boolean, default: false
    field :hotel_zimmer_tv_kabel,                  type: Boolean, default: false
    field :hotel_zimmer_tv_sat,                    type: Boolean, default: false
    field :hotel_zimmer_wc,                        type: Boolean, default: false
    field :hotel_zimmer_wecker,                    type: Boolean, default: false
    field :hotel_zimmer_wlan_kostenlos,            type: Boolean, default: false
    field :hotel_zimmer_wlan,                      type: Boolean, default: false
  end

  module ClassMethods
    def hotel_attribute_names
      ['is_hotel'] + attributes_with_prefix('hotel')
    end

    def hotel_ausstattung_attribute_names
      attributes_with_prefix 'hotel_ausstattung'
    end

    def hotel_essen_attribute_names
      attributes_with_prefix 'hotel_essen'
    end

    def hotel_service_attribute_names
      attributes_with_prefix 'hotel_service'
    end

    def hotel_zimmer_attribute_names
      attributes_with_prefix 'hotel_zimmer'
    end
  end
end
