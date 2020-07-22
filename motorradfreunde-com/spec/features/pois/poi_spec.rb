feature 'Pois', js: true do
  let(:homer) { create :homer }

  scenario 'I should see all pois' do
    poi = create :poi
    visit '/'
    within 'nav.main-navigation' do
      click_on 'Orte'
      click_on 'Alle'
    end
    expect(page).to have_content poi
  end

  scenario 'I should see a poi detail page' do
    poi = create :poi
    visit "/orte/#{poi.slug}"
    expect(page).to have_content poi
  end

  scenario 'I should be able to create a poi' do
    sign_in homer
    poi = build :poi
    visit "/orte"
    click_on 'POI anlegen'
    within 'form.new_poi' do
      fill_in 'Name', with: poi.name
      click_on 'Speichern'
    end
    expect(page).to have_content poi.name
  end

  scenario 'I should be able to edit a poi' do
    poi = create :poi, creator: homer
    sign_in homer
    visit "/orte/#{poi.slug}"
    click_on 'POI bearbeiten'
    within 'form.edit_poi' do
      fill_in 'Name', with: 'A new poi name'
      click_on 'Speichern'
    end
    expect(page).to have_content 'A new poi name'
  end

end
