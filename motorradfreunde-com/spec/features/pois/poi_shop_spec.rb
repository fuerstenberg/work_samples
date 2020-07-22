feature 'Poi shop', js: true do
  let(:homer) { create :homer }

  scenario 'I should be able to create a poi' do
    sign_in homer
    visit "/orte"

    click_on 'POI anlegen'
    within 'form.new_poi' do
      check 'poi[is_shop]'
      fill_in 'poi[name]',                          with: 'My shop'

      fill_in 'poi[address_attributes][street]',    with: 'Wernickstraße 22'
      fill_in 'poi[address_attributes][zip]',       with: '99817'
      fill_in 'poi[address_attributes][city]',      with: 'Eisenach'
      fill_in 'poi[address_attributes][state]',     with: 'Thüringen'
      fill_in 'poi[address_attributes][country]',   with: 'Deutschland'

      fill_in 'poi[shop_beschreibung]',        with: 'shop_beschreibung'
      check 'poi[shop_bekleidung]'
      check 'poi[shop_bekleidung_helme]'
      check 'poi[shop_bekleidung_leder]'
      check 'poi[shop_bekleidung_textil]'
      check 'poi[shop_finanzierung]'
      check 'poi[shop_geschenkgutscheine]'
      check 'poi[shop_zubehoer]'
      click_on 'Speichern'
    end

    expect(page).to have_content 'My shop'

    expect(page).to have_content 'Wernickstraße 22'
    expect(page).to have_content '99817'
    expect(page).to have_content 'Eisenach'
    expect(page).to have_content 'Thüringen'
    expect(page).to have_content 'Deutschland'

    expect(page).to have_content 'shop_beschreibung'

    expect(page).to have_selector '.shop_bekleidung'
    expect(page).to have_selector '.shop_bekleidung_helme'
    expect(page).to have_selector '.shop_bekleidung_leder'
    expect(page).to have_selector '.shop_bekleidung_textil'
    expect(page).to have_selector '.shop_finanzierung'
    expect(page).to have_selector '.shop_geschenkgutscheine'
    expect(page).to have_selector '.shop_zubehoer'
  end

end
