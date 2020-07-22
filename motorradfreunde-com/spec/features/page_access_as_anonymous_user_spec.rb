feature 'Page access as anonymous user', js: true do
  given!(:bart)   { FactoryGirl.create(:bart ) }
  given!(:nelson) { FactoryGirl.create(:nelson ) }

  scenario 'root' do
    visit '/'
    expect(page).to have_http_status 200
    expect(page).to have_content 'Der Bikertreff für Motorradfreunde.'
  end

  scenario 'biker' do
    visit '/biker'
    expect(page).to have_http_status 200
    expect(page).to have_content 'Motorradfahrer'
  end

  scenario 'biker/nelson' do
    visit "/biker/#{nelson.slug}"
    expect(page).to have_http_status 200
    expect(page.current_path).to eq '/users/login'
  end

  # scenario 'orte' do
  #   visit '/orte'
  #   expect(page).to have_http_status 200
  #   expect(page).to have_content 'Orte, die Motorradfahrer lieben'
  # end

  # scenario 'orte/spinnerbruecke' do
  #   visit "/orte/#{spinnerbruecke.slug}"
  #   expect(page).to have_http_status 200
  #   expect(page).to have_content 'Orte, die Motorradfahrer lieben'
  # end

  # scenario 'motorraeder' do
  #   visit '/motorraeder'
  #   expect(page).to have_http_status 200
  #   expect(page).to have_content 'Hier findest du Motorräder aller hier angemeldeten Biker.'
  # end

  scenario 'motorradtreffen' do
    visit '/motorradtreffen'
    expect(page).to have_http_status 200
    expect(page).to have_content 'Motorradtreffen'
  end

  scenario 'motorradtouren' do
    visit '/motorradtouren'
    expect(page).to have_http_status 200
    expect(page).to have_content 'Beliebte Motorradtouren'
  end

  scenario 'motorradvideos' do
    visit '/motorradvideos'
    expect(page).to have_http_status 200
    expect(page).to have_content 'Motorradvideos'
  end

  scenario 'forum' do
    visit '/forum'
    expect(page).to have_http_status 200
    expect(page).to have_content 'Motorradforum'
  end

end
