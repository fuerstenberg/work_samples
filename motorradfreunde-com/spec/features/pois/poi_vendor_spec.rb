feature 'Poi vendor', js: true do
  let(:homer) { create :homer }

  scenario 'I should be able to create a poi' do
    sign_in homer
    visit "/orte"

    click_on 'POI anlegen'
    within 'form.new_poi' do
      check 'poi[is_vendor]'
      fill_in 'poi[name]',                    with: 'My vendor'
      fill_in 'poi[hersteller_beschreibung]', with: 'hersteller_beschreibung'
      click_on 'Speichern'
    end

    expect(page).to have_content 'My vendor'
    expect(page).to have_content 'hersteller_beschreibung'
  end

end
