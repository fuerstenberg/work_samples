feature 'Poi rental_company', js: true do
  let(:homer) { create :homer }

  scenario 'I should be able to create a poi' do
    sign_in homer
    visit "/orte"

    click_on 'POI anlegen'
    within 'form.new_poi' do
      check 'poi[is_rental_company]'
      fill_in 'poi[name]',                          with: 'My rental_company'

      fill_in 'poi[address_attributes][street]',    with: 'Wernickstraße 22'
      fill_in 'poi[address_attributes][zip]',       with: '99817'
      fill_in 'poi[address_attributes][city]',      with: 'Eisenach'
      fill_in 'poi[address_attributes][state]',     with: 'Thüringen'
      fill_in 'poi[address_attributes][country]',   with: 'Deutschland'

      fill_in 'poi[vermietung_beschreibung]',        with: 'vermietung_beschreibung'
      click_on 'Speichern'
    end

    expect(page).to have_content 'My rental_company'

    expect(page).to have_content 'Wernickstraße 22'
    expect(page).to have_content '99817'
    expect(page).to have_content 'Eisenach'
    expect(page).to have_content 'Thüringen'
    expect(page).to have_content 'Deutschland'

    expect(page).to have_content 'vermietung_beschreibung'
  end

end
