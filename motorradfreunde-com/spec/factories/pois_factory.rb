FactoryGirl.define do
  factory :poi do
    contact              "Homer Simpson"
    description          "Beschde Bikes die wo gibt"
    email
    enabled_at           "2012-11-01"
    enabled_until        "2012-11-01"
    fax                  "1456789"
    mobile               '0171 5253466'
    import_url           "http://www.bmw-motorrad.de"
    name                 "BMW"
    opening_times        "10:00 - 20:00 Uhr"
    phone                "1456789"
    published            true
    premium              false
    website              { "http://www.bmw-motorrad-#{rand(9999)}.de" }

    factory :vendor do
      name "BMW"
      is_vendor true
      initialize_with { Poi.vendors.find_or_create_by(name: name)}
    end

    trait :with_address do
      association :address, factory: :address, strategy: :build
    end

    trait :bike_builder do
      is_bike_builder true
      motorradbauer_beschreibung 'motorradbauer_beschreibung'
    end

    trait :dealer do
      is_dealer true
      haendler_beschreibung 'haendler_beschreibung'
      haendler_finanzierung true
      haendler_marken       'haendler_marken'
    end

    trait :hotel do
      is_hotel                                true
      hotel_lage                              { ['schön gelegen, direkt an der Autobahn', 'direkt in den Bergen gelegen'].sample }
      hotel_typ                               { ['Pension', 'Hotel', 'Privatunterkunft'].sample }

      hotel_anzahl_sterne                     { [1,2,3,4,5].sample }
      hotel_anzahl_appartments                { (1..30).to_a.sample }
      hotel_anzahl_betten                     { (1..30).to_a.sample }
      hotel_anzahl_doppelzimmer               { (1..30).to_a.sample }
      hotel_anzahl_einzelzimmer               { (1..30).to_a.sample }
      hotel_anzahl_mehrbettzimmer             { (1..30).to_a.sample }
      hotel_anzahl_zimmer                     { (1..30).to_a.sample }

      hotel_ausstattung_aufenthaltsraum       true
      hotel_ausstattung_badestrand            true
      hotel_ausstattung_bar                   true
      hotel_ausstattung_garage_abschliessbar  true
      hotel_ausstattung_garage_kostenlos      true
      hotel_ausstattung_garage_motorrad       true
      hotel_ausstattung_garage                true
      hotel_ausstattung_liegewiese            true
      hotel_ausstattung_lift_garage           true
      hotel_ausstattung_lift                  true
      hotel_ausstattung_motorradwaschplatz    true
      hotel_ausstattung_parkplatz_anhaenger   true
      hotel_ausstattung_parkplatz_ueberdacht  true
      hotel_ausstattung_parkplatz             true
      hotel_ausstattung_pool                  true
      hotel_ausstattung_saal                  true
      hotel_ausstattung_sauna                 true
      hotel_ausstattung_schrauberecke         true
      hotel_ausstattung_terrasse              true
      hotel_ausstattung_trockenraum           true
      hotel_ausstattung_werkzeug              true
      hotel_ausstattung_wlan_kostenlos        true
      hotel_ausstattung_wlan                  true
      hotel_essen_biergarten                  true
      hotel_essen_fruehstueck                 true
      hotel_essen_fruehstuecksbuffet          true
      hotel_essen_grillplatz                  true
      hotel_essen_halbpension                 true
      hotel_essen_lunchpaket                  true
      hotel_essen_restaurant                  true
      hotel_essen_vollpension                 true
      hotel_service_chef_ist_biker            true
      hotel_service_gartennutzung             true
      hotel_service_tourenkarte               true
      hotel_service_tourentipps               true
      hotel_service_waesche                   true
      hotel_service_wellness                  true
      hotel_zimmer_badewanne                  true
      hotel_zimmer_balkon                     true
      hotel_zimmer_bettwaesche                true
      hotel_zimmer_dusche                     true
      hotel_zimmer_haartrockner               true
      hotel_zimmer_handtuecher                true
      hotel_zimmer_minibar                    true
      hotel_zimmer_nichtraucher               true
      hotel_zimmer_radio                      true
      hotel_zimmer_terrasse                   true
      hotel_zimmer_tv_kabel                   true
      hotel_zimmer_tv_sat                     true
      hotel_zimmer_wc                         true
      hotel_zimmer_wecker                     true
      hotel_zimmer_wlan_kostenlos             true
      hotel_zimmer_wlan                       true
    end

    trait :magazin do
      is_magazin true
      magazin_beschreibung 'magazin_beschreibung'
    end

    trait :mountain_pass do
      is_mountain_pass true
      pass_beschreibung 'pass_beschreibung'
    end

    trait :rental_company do
      is_rental_company true
      vermietung_beschreibung 'vermietung_beschreibung'
    end

    trait :shop do
      is_shop true
      shop_beschreibung       'shop_beschreibung'
      shop_bekleidung         true
      shop_bekleidung_helme   true
      shop_bekleidung_leder   true
      shop_bekleidung_textil  true
      shop_finanzierung       true
      shop_geschenkgutscheine true
      shop_zubehoer           true
    end

    trait :tour_operator do
      is_tour_operator true
      reiseanbieter_beschreibung 'reiseanbieter_beschreibung'
      reiseanbieter_touren       true
      reiseanbieter_reisen       true
    end

    trait :vendor do
      is_vendor true
      hersteller_beschreibung 'hersteller_beschreibung'
    end

    trait :workshop do
      is_workshop true
      werkstatt_beschreibung          'werkstatt_beschreibung'
      werkstatt_austauschmotorraeder  true
      werkstatt_ist_typenoffen        true
      werkstatt_marken                'werkstatt_marken'
      werkstatt_hol_bring     true
      werkstatt_hu            true
      werkstatt_inspektionen  true
      werkstatt_pannenservice true
      werkstatt_reifen        true
      werkstatt_reparatur     true
      werkstatt_stellplaetze   true
      werkstatt_tuev          true
      werkstatt_umbauten      true
    end

  end
end
