feature 'Poi tour_operator', js: true do
  let(:homer) { create :homer }

  scenario 'I should be able to create a poi' do
    sign_in homer
    visit "/orte"

    click_on 'POI anlegen'
    within 'form.new_poi' do
      check 'poi[is_tour_operator]'
      fill_in 'poi[name]',                          with: 'My tour_operator'
      fill_in 'poi[reiseanbieter_beschreibung]',        with: 'reiseanbieter_beschreibung'

      check 'poi[reiseanbieter_touren]'
      check 'poi[reiseanbieter_reisen]'
      click_on 'Speichern'
    end

    expect(page).to have_content 'My tour_operator'
    expect(page).to have_content 'reiseanbieter_beschreibung'

    expect(page).to have_selector '.reiseanbieter_touren'
    expect(page).to have_selector '.reiseanbieter_reisen'
  end

end
