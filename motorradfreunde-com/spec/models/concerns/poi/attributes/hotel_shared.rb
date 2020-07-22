shared_examples "a hotel" do
  context 'general' do
  end

  context 'concerns' do
  end

  context 'associations' do
  end

  context 'fields' do
    it { is_expected.to have_field(:is_hotel                              ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_beschreibung                    ).of_type(String).with_default_value_of('') }
    it { is_expected.to have_field(:hotel_lage                            ).of_type(String).with_default_value_of('') }
    it { is_expected.to have_field(:hotel_typ                             ).of_type(String).with_default_value_of('') }

    it { is_expected.to have_field(:hotel_anzahl_sterne                   ).of_type(Integer).with_default_value_of(0) }
    it { is_expected.to have_field(:hotel_anzahl_appartments              ).of_type(Integer).with_default_value_of(0) }
    it { is_expected.to have_field(:hotel_anzahl_betten                   ).of_type(Integer).with_default_value_of(0) }
    it { is_expected.to have_field(:hotel_anzahl_doppelzimmer             ).of_type(Integer).with_default_value_of(0) }
    it { is_expected.to have_field(:hotel_anzahl_einzelzimmer             ).of_type(Integer).with_default_value_of(0) }
    it { is_expected.to have_field(:hotel_anzahl_mehrbettzimmer           ).of_type(Integer).with_default_value_of(0) }
    it { is_expected.to have_field(:hotel_anzahl_zimmer                   ).of_type(Integer).with_default_value_of(0) }

    it { is_expected.to have_field(:hotel_ausstattung_aufenthaltsraum     ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_ausstattung_badestrand          ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_ausstattung_bar                 ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_ausstattung_garage_abschliessbar).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_ausstattung_garage_kostenlos    ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_ausstattung_garage_motorrad     ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_ausstattung_garage              ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_ausstattung_liegewiese          ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_ausstattung_lift_garage         ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_ausstattung_lift                ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_ausstattung_motorradwaschplatz  ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_ausstattung_parkplatz_anhaenger ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_ausstattung_parkplatz_ueberdacht).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_ausstattung_parkplatz           ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_ausstattung_pool                ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_ausstattung_saal                ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_ausstattung_sauna               ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_ausstattung_schrauberecke       ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_ausstattung_terrasse            ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_ausstattung_trockenraum         ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_ausstattung_werkzeug            ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_ausstattung_wlan_kostenlos      ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_ausstattung_wlan                ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_essen_biergarten                ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_essen_fruehstueck               ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_essen_fruehstuecksbuffet        ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_essen_grillplatz                ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_essen_halbpension               ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_essen_lunchpaket                ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_essen_restaurant                ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_essen_vollpension               ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_service_chef_ist_biker          ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_service_gartennutzung           ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_service_tourenkarte             ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_service_tourentipps             ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_service_waesche                 ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_service_wellness                ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_zimmer_badewanne                ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_zimmer_balkon                   ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_zimmer_bettwaesche              ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_zimmer_dusche                   ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_zimmer_haartrockner             ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_zimmer_handtuecher              ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_zimmer_minibar                  ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_zimmer_nichtraucher             ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_zimmer_radio                    ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_zimmer_terrasse                 ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_zimmer_tv_kabel                 ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_zimmer_tv_sat                   ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_zimmer_wc                       ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_zimmer_wecker                   ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_zimmer_wlan_kostenlos           ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:hotel_zimmer_wlan                     ).of_type(Mongoid::Boolean).with_default_value_of(false) }
  end

  context 'validations' do
  end

  context 'class methods' do
  end

  context 'instance methods' do
  end
end
