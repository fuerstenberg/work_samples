feature 'Poi workshop', js: true do
  let(:homer) { create :homer }

  scenario 'I should be able to create a poi' do
    sign_in homer
    visit "/orte"

    click_on 'POI anlegen'
    within 'form.new_poi' do
      check 'poi[is_workshop]'
      fill_in 'poi[name]',                          with: 'My workshop'

      fill_in 'poi[address_attributes][street]',    with: 'Wernickstraße 22'
      fill_in 'poi[address_attributes][zip]',       with: '99817'
      fill_in 'poi[address_attributes][city]',      with: 'Eisenach'
      fill_in 'poi[address_attributes][state]',     with: 'Thüringen'
      fill_in 'poi[address_attributes][country]',   with: 'Deutschland'

      fill_in 'poi[werkstatt_beschreibung]',        with: 'werkstatt_beschreibung'
      fill_in 'poi[werkstatt_marken]',              with: 'werkstatt_marken'
      check 'poi[werkstatt_austauschmotorraeder]'
      check 'poi[werkstatt_ist_typenoffen]'
      check 'poi[werkstatt_hol_bring]'
      check 'poi[werkstatt_hu]'
      check 'poi[werkstatt_inspektionen]'
      check 'poi[werkstatt_pannenservice]'
      check 'poi[werkstatt_reifen]'
      check 'poi[werkstatt_reparatur]'
      check 'poi[werkstatt_stellplaetze]'
      check 'poi[werkstatt_tuev]'
      check 'poi[werkstatt_umbauten]'
      click_on 'Speichern'
    end

    expect(page).to have_content 'My workshop'

    expect(page).to have_content 'Wernickstraße 22'
    expect(page).to have_content '99817'
    expect(page).to have_content 'Eisenach'
    expect(page).to have_content 'Thüringen'
    expect(page).to have_content 'Deutschland'

    expect(page).to have_content 'werkstatt_beschreibung'
    expect(page).to have_content 'werkstatt_marken'

    expect(page).to have_selector '.werkstatt_austauschmotorraeder'
    expect(page).to have_selector '.werkstatt_ist_typenoffen'
    expect(page).to have_selector '.werkstatt_hol_bring'
    expect(page).to have_selector '.werkstatt_hu'
    expect(page).to have_selector '.werkstatt_inspektionen'
    expect(page).to have_selector '.werkstatt_pannenservice'
    expect(page).to have_selector '.werkstatt_reifen'
    expect(page).to have_selector '.werkstatt_reparatur'
    expect(page).to have_selector '.werkstatt_stellplaetze'
    expect(page).to have_selector '.werkstatt_tuev'
    expect(page).to have_selector '.werkstatt_umbauten'
  end

end
