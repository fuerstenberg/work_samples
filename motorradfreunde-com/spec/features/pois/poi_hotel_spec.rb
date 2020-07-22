feature 'Pois as hotel', js: true do
  let(:homer) { create :homer }

  scenario 'I should see a detail page' do
    poi = create :poi, :hotel
    visit "/orte/#{poi.slug}"
    within '.content' do
      expect(page).to have_content poi
      within '.hotel_typ' do
        expect(page).to have_content poi.hotel_typ
      end
      within 'dd.hotel_lage' do
        expect(page).to have_content poi.hotel_lage
      end
      within 'dd.hotel_anzahl_sterne' do
        expect(page).to have_content poi.hotel_anzahl_sterne
      end
      within 'dd.hotel_anzahl_appartments' do
        expect(page).to have_content poi.hotel_anzahl_appartments
      end
      within 'dd.hotel_anzahl_betten' do
        expect(page).to have_content poi.hotel_anzahl_betten
      end
      within 'dd.hotel_anzahl_doppelzimmer' do
        expect(page).to have_content poi.hotel_anzahl_doppelzimmer
      end
      within 'dd.hotel_anzahl_einzelzimmer' do
        expect(page).to have_content poi.hotel_anzahl_einzelzimmer
      end
      within 'dd.hotel_anzahl_mehrbettzimmer' do
        expect(page).to have_content poi.hotel_anzahl_mehrbettzimmer
      end
      within 'dd.hotel_anzahl_zimmer' do
        expect(page).to have_content poi.hotel_anzahl_zimmer
      end

      expect(page).to have_selector '.hotel_ausstattung_aufenthaltsraum'
      expect(page).to have_selector '.hotel_ausstattung_badestrand'
      expect(page).to have_selector '.hotel_ausstattung_bar'
      expect(page).to have_selector '.hotel_ausstattung_garage_abschliessbar'
      expect(page).to have_selector '.hotel_ausstattung_garage_kostenlos'
      expect(page).to have_selector '.hotel_ausstattung_garage_motorrad'
      expect(page).to have_selector '.hotel_ausstattung_garage'
      expect(page).to have_selector '.hotel_ausstattung_liegewiese'
      expect(page).to have_selector '.hotel_ausstattung_lift_garage'
      expect(page).to have_selector '.hotel_ausstattung_lift'
      expect(page).to have_selector '.hotel_ausstattung_motorradwaschplatz'
      expect(page).to have_selector '.hotel_ausstattung_parkplatz_anhaenger'
      expect(page).to have_selector '.hotel_ausstattung_parkplatz_ueberdacht'
      expect(page).to have_selector '.hotel_ausstattung_parkplatz'
      expect(page).to have_selector '.hotel_ausstattung_pool'
      expect(page).to have_selector '.hotel_ausstattung_saal'
      expect(page).to have_selector '.hotel_ausstattung_sauna'
      expect(page).to have_selector '.hotel_ausstattung_schrauberecke'
      expect(page).to have_selector '.hotel_ausstattung_terrasse'
      expect(page).to have_selector '.hotel_ausstattung_trockenraum'
      expect(page).to have_selector '.hotel_ausstattung_werkzeug'
      expect(page).to have_selector '.hotel_ausstattung_wlan_kostenlos'
      expect(page).to have_selector '.hotel_ausstattung_wlan'
      expect(page).to have_selector '.hotel_essen_biergarten'
      expect(page).to have_selector '.hotel_essen_fruehstueck'
      expect(page).to have_selector '.hotel_essen_fruehstuecksbuffet'
      expect(page).to have_selector '.hotel_essen_grillplatz'
      expect(page).to have_selector '.hotel_essen_halbpension'
      expect(page).to have_selector '.hotel_essen_lunchpaket'
      expect(page).to have_selector '.hotel_essen_restaurant'
      expect(page).to have_selector '.hotel_essen_vollpension'
      expect(page).to have_selector '.hotel_service_chef_ist_biker'
      expect(page).to have_selector '.hotel_service_gartennutzung'
      expect(page).to have_selector '.hotel_service_tourenkarte'
      expect(page).to have_selector '.hotel_service_tourentipps'
      expect(page).to have_selector '.hotel_service_waesche'
      expect(page).to have_selector '.hotel_service_wellness'
      expect(page).to have_selector '.hotel_zimmer_badewanne'
      expect(page).to have_selector '.hotel_zimmer_balkon'
      expect(page).to have_selector '.hotel_zimmer_bettwaesche'
      expect(page).to have_selector '.hotel_zimmer_dusche'
      expect(page).to have_selector '.hotel_zimmer_haartrockner'
      expect(page).to have_selector '.hotel_zimmer_handtuecher'
      expect(page).to have_selector '.hotel_zimmer_minibar'
      expect(page).to have_selector '.hotel_zimmer_nichtraucher'
      expect(page).to have_selector '.hotel_zimmer_radio'
      expect(page).to have_selector '.hotel_zimmer_terrasse'
      expect(page).to have_selector '.hotel_zimmer_tv_kabel'
      expect(page).to have_selector '.hotel_zimmer_tv_sat'
      expect(page).to have_selector '.hotel_zimmer_wc'
      expect(page).to have_selector '.hotel_zimmer_wecker'
      expect(page).to have_selector '.hotel_zimmer_wlan_kostenlos'
      expect(page).to have_selector '.hotel_zimmer_wlan'
    end
  end

  scenario 'I should be able to create' do
    poi = build :poi, :hotel
    sign_in homer
    visit '/orte'
    click_on 'POI anlegen'

    within 'form.new_poi' do
      check 'Motorradhotel'
      fill_in 'Name', with: poi.name

      fill_in 'poi[address_attributes][street]',    with: 'Wernickstraße 22'
      fill_in 'poi[address_attributes][zip]',       with: '99817'
      fill_in 'poi[address_attributes][city]',      with: 'Eisenach'
      fill_in 'poi[address_attributes][state]',     with: 'Thüringen'
      fill_in 'poi[address_attributes][country]',   with: 'Deutschland'

      fill_in I18n.t('mongoid.attributes.poi.hotel_typ'), with: poi.hotel_typ
      fill_in I18n.t('mongoid.attributes.poi.hotel_lage'), with: poi.hotel_lage
      fill_in I18n.t('mongoid.attributes.poi.hotel_anzahl_sterne'), with: poi.hotel_anzahl_sterne
      fill_in I18n.t('mongoid.attributes.poi.hotel_anzahl_appartments'), with: poi.hotel_anzahl_appartments
      fill_in I18n.t('mongoid.attributes.poi.hotel_anzahl_betten'), with: poi.hotel_anzahl_betten
      fill_in I18n.t('mongoid.attributes.poi.hotel_anzahl_doppelzimmer'), with: poi.hotel_anzahl_doppelzimmer
      fill_in I18n.t('mongoid.attributes.poi.hotel_anzahl_einzelzimmer'), with: poi.hotel_anzahl_einzelzimmer
      fill_in I18n.t('mongoid.attributes.poi.hotel_anzahl_mehrbettzimmer'), with: poi.hotel_anzahl_mehrbettzimmer
      fill_in I18n.t('mongoid.attributes.poi.hotel_anzahl_zimmer'), with: poi.hotel_anzahl_zimmer

      within '.hotel_ausstattung' do
        check I18n.t('mongoid.attributes.poi.hotel_ausstattung_aufenthaltsraum')
        check I18n.t('mongoid.attributes.poi.hotel_ausstattung_badestrand')
        check I18n.t('mongoid.attributes.poi.hotel_ausstattung_bar')
        check I18n.t('mongoid.attributes.poi.hotel_ausstattung_garage_abschliessbar')
        check I18n.t('mongoid.attributes.poi.hotel_ausstattung_garage_kostenlos')
        check I18n.t('mongoid.attributes.poi.hotel_ausstattung_garage_motorrad')
        check I18n.t('mongoid.attributes.poi.hotel_ausstattung_garage')
        check I18n.t('mongoid.attributes.poi.hotel_ausstattung_liegewiese')
        check I18n.t('mongoid.attributes.poi.hotel_ausstattung_lift_garage')
        check I18n.t('mongoid.attributes.poi.hotel_ausstattung_lift')
        check I18n.t('mongoid.attributes.poi.hotel_ausstattung_motorradwaschplatz')
        check I18n.t('mongoid.attributes.poi.hotel_ausstattung_parkplatz_anhaenger')
        check I18n.t('mongoid.attributes.poi.hotel_ausstattung_parkplatz_ueberdacht')
        check I18n.t('mongoid.attributes.poi.hotel_ausstattung_parkplatz')
        check I18n.t('mongoid.attributes.poi.hotel_ausstattung_pool')
        check I18n.t('mongoid.attributes.poi.hotel_ausstattung_saal')
        check I18n.t('mongoid.attributes.poi.hotel_ausstattung_sauna')
        check I18n.t('mongoid.attributes.poi.hotel_ausstattung_schrauberecke')
        check I18n.t('mongoid.attributes.poi.hotel_ausstattung_terrasse')
        check I18n.t('mongoid.attributes.poi.hotel_ausstattung_trockenraum')
        check I18n.t('mongoid.attributes.poi.hotel_ausstattung_werkzeug')
        check I18n.t('mongoid.attributes.poi.hotel_ausstattung_wlan_kostenlos')
        check I18n.t('mongoid.attributes.poi.hotel_ausstattung_wlan')
      end
      within '.hotel_essen' do
        check I18n.t('mongoid.attributes.poi.hotel_essen_biergarten')
        check I18n.t('mongoid.attributes.poi.hotel_essen_fruehstueck')
        check I18n.t('mongoid.attributes.poi.hotel_essen_fruehstuecksbuffet')
        check I18n.t('mongoid.attributes.poi.hotel_essen_grillplatz')
        check I18n.t('mongoid.attributes.poi.hotel_essen_halbpension')
        check I18n.t('mongoid.attributes.poi.hotel_essen_lunchpaket')
        check I18n.t('mongoid.attributes.poi.hotel_essen_restaurant')
        check I18n.t('mongoid.attributes.poi.hotel_essen_vollpension')
      end
      within '.hotel_service' do
        check I18n.t('mongoid.attributes.poi.hotel_service_chef_ist_biker')
        check I18n.t('mongoid.attributes.poi.hotel_service_gartennutzung')
        check I18n.t('mongoid.attributes.poi.hotel_service_tourenkarte')
        check I18n.t('mongoid.attributes.poi.hotel_service_tourentipps')
        check I18n.t('mongoid.attributes.poi.hotel_service_waesche')
        check I18n.t('mongoid.attributes.poi.hotel_service_wellness')
      end
      within '.hotel_zimmer' do
        check I18n.t('mongoid.attributes.poi.hotel_zimmer_badewanne')
        check I18n.t('mongoid.attributes.poi.hotel_zimmer_balkon')
        check I18n.t('mongoid.attributes.poi.hotel_zimmer_bettwaesche')
        check I18n.t('mongoid.attributes.poi.hotel_zimmer_dusche')
        check I18n.t('mongoid.attributes.poi.hotel_zimmer_haartrockner')
        check I18n.t('mongoid.attributes.poi.hotel_zimmer_handtuecher')
        check I18n.t('mongoid.attributes.poi.hotel_zimmer_minibar')
        check I18n.t('mongoid.attributes.poi.hotel_zimmer_nichtraucher')
        check I18n.t('mongoid.attributes.poi.hotel_zimmer_radio')
        check I18n.t('mongoid.attributes.poi.hotel_zimmer_terrasse')
        check I18n.t('mongoid.attributes.poi.hotel_zimmer_tv_kabel')
        check I18n.t('mongoid.attributes.poi.hotel_zimmer_tv_sat')
        check I18n.t('mongoid.attributes.poi.hotel_zimmer_wc')
        check I18n.t('mongoid.attributes.poi.hotel_zimmer_wecker')
        check I18n.t('mongoid.attributes.poi.hotel_zimmer_wlan_kostenlos')
        check I18n.t('mongoid.attributes.poi.hotel_zimmer_wlan')
      end
      click_on 'Speichern'
    end

    expect(page).to have_content 'Wernickstraße 22'
    expect(page).to have_content '99817'
    expect(page).to have_content 'Eisenach'
    expect(page).to have_content 'Thüringen'
    expect(page).to have_content 'Deutschland'

    within '.hotel_typ' do
      expect(page).to have_content poi.hotel_typ
    end
    within 'dd.hotel_lage' do
      expect(page).to have_content poi.hotel_lage
    end
    within 'dd.hotel_anzahl_sterne' do
      expect(page).to have_content poi.hotel_anzahl_sterne
    end
    within 'dd.hotel_anzahl_appartments' do
      expect(page).to have_content poi.hotel_anzahl_appartments
    end
    within 'dd.hotel_anzahl_betten' do
      expect(page).to have_content poi.hotel_anzahl_betten
    end
    within 'dd.hotel_anzahl_doppelzimmer' do
      expect(page).to have_content poi.hotel_anzahl_doppelzimmer
    end
    within 'dd.hotel_anzahl_einzelzimmer' do
      expect(page).to have_content poi.hotel_anzahl_einzelzimmer
    end
    within 'dd.hotel_anzahl_mehrbettzimmer' do
      expect(page).to have_content poi.hotel_anzahl_mehrbettzimmer
    end
    within 'dd.hotel_anzahl_zimmer' do
      expect(page).to have_content poi.hotel_anzahl_zimmer
    end

    expect(page).to have_selector '.hotel_ausstattung_aufenthaltsraum'
    expect(page).to have_selector '.hotel_ausstattung_badestrand'
    expect(page).to have_selector '.hotel_ausstattung_bar'
    expect(page).to have_selector '.hotel_ausstattung_garage_abschliessbar'
    expect(page).to have_selector '.hotel_ausstattung_garage_kostenlos'
    expect(page).to have_selector '.hotel_ausstattung_garage_motorrad'
    expect(page).to have_selector '.hotel_ausstattung_garage'
    expect(page).to have_selector '.hotel_ausstattung_liegewiese'
    expect(page).to have_selector '.hotel_ausstattung_lift_garage'
    expect(page).to have_selector '.hotel_ausstattung_lift'
    expect(page).to have_selector '.hotel_ausstattung_motorradwaschplatz'
    expect(page).to have_selector '.hotel_ausstattung_parkplatz_anhaenger'
    expect(page).to have_selector '.hotel_ausstattung_parkplatz_ueberdacht'
    expect(page).to have_selector '.hotel_ausstattung_parkplatz'
    expect(page).to have_selector '.hotel_ausstattung_pool'
    expect(page).to have_selector '.hotel_ausstattung_saal'
    expect(page).to have_selector '.hotel_ausstattung_sauna'
    expect(page).to have_selector '.hotel_ausstattung_schrauberecke'
    expect(page).to have_selector '.hotel_ausstattung_terrasse'
    expect(page).to have_selector '.hotel_ausstattung_trockenraum'
    expect(page).to have_selector '.hotel_ausstattung_werkzeug'
    expect(page).to have_selector '.hotel_ausstattung_wlan_kostenlos'
    expect(page).to have_selector '.hotel_ausstattung_wlan'
    expect(page).to have_selector '.hotel_essen_biergarten'
    expect(page).to have_selector '.hotel_essen_fruehstueck'
    expect(page).to have_selector '.hotel_essen_fruehstuecksbuffet'
    expect(page).to have_selector '.hotel_essen_grillplatz'
    expect(page).to have_selector '.hotel_essen_halbpension'
    expect(page).to have_selector '.hotel_essen_lunchpaket'
    expect(page).to have_selector '.hotel_essen_restaurant'
    expect(page).to have_selector '.hotel_essen_vollpension'
    expect(page).to have_selector '.hotel_service_chef_ist_biker'
    expect(page).to have_selector '.hotel_service_gartennutzung'
    expect(page).to have_selector '.hotel_service_tourenkarte'
    expect(page).to have_selector '.hotel_service_tourentipps'
    expect(page).to have_selector '.hotel_service_waesche'
    expect(page).to have_selector '.hotel_service_wellness'
    expect(page).to have_selector '.hotel_zimmer_badewanne'
    expect(page).to have_selector '.hotel_zimmer_balkon'
    expect(page).to have_selector '.hotel_zimmer_bettwaesche'
    expect(page).to have_selector '.hotel_zimmer_dusche'
    expect(page).to have_selector '.hotel_zimmer_haartrockner'
    expect(page).to have_selector '.hotel_zimmer_handtuecher'
    expect(page).to have_selector '.hotel_zimmer_minibar'
    expect(page).to have_selector '.hotel_zimmer_nichtraucher'
    expect(page).to have_selector '.hotel_zimmer_radio'
    expect(page).to have_selector '.hotel_zimmer_terrasse'
    expect(page).to have_selector '.hotel_zimmer_tv_kabel'
    expect(page).to have_selector '.hotel_zimmer_tv_sat'
    expect(page).to have_selector '.hotel_zimmer_wc'
    expect(page).to have_selector '.hotel_zimmer_wecker'
    expect(page).to have_selector '.hotel_zimmer_wlan_kostenlos'
    expect(page).to have_selector '.hotel_zimmer_wlan'
  end

end
