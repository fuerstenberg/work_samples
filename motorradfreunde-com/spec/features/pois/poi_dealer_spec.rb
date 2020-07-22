feature 'Poi dealer', js: true do
  let(:homer) { create :homer }

  scenario 'I should be able to create a poi' do
    sign_in homer
    visit "/orte"

    click_on 'POI anlegen'
    within 'form.new_poi' do
      check 'poi[is_dealer]'
      fill_in 'poi[name]',                          with: 'My dealer'

      fill_in 'poi[address_attributes][street]',    with: 'Wernickstraße 22'
      fill_in 'poi[address_attributes][zip]',       with: '99817'
      fill_in 'poi[address_attributes][city]',      with: 'Eisenach'
      fill_in 'poi[address_attributes][state]',     with: 'Thüringen'
      fill_in 'poi[address_attributes][country]',   with: 'Deutschland'

      fill_in 'poi[haendler_beschreibung]',        with: 'haendler_beschreibung'
      fill_in 'poi[haendler_marken]',              with: 'haendler_marken'
      check 'poi[haendler_finanzierung]'
      click_on 'Speichern'
    end

    expect(page).to have_content 'My dealer'

    expect(page).to have_content 'Wernickstraße 22'
    expect(page).to have_content '99817'
    expect(page).to have_content 'Eisenach'
    expect(page).to have_content 'Thüringen'
    expect(page).to have_content 'Deutschland'

    expect(page).to have_content 'haendler_beschreibung'
    expect(page).to have_content 'haendler_marken'

    expect(page).to have_selector '.haendler_finanzierung'
  end

end
