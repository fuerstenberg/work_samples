feature 'Events', js: true do
  let(:user) { FactoryGirl.create(:user) }

  scenario 'I should see all events' do
    events = create_list :random_event, 10

    visit '/motorradtreffen'
    expect(events.count).to eq 10
    events.each do |event|
      expect(page).to have_content event.to_s
    end
  end

  scenario 'I should see an event' do
    I18n.locale = :de

    event = create :random_event, :with_address
    visit "/motorradtreffen/#{event.slug}"
    expect(page).to have_content event.title
    expect(page).to have_content event.description
    expect(page).to have_content event.url
    expect(page).to have_content I18n.l( event.start_at, format: :longest)
    expect(page).to have_content I18n.l( event.end_at,   format: :longest)
  end

  scenario 'I should be able to create an event' do
    event = build :random_event, :with_address
    sign_in user
    visit "/motorradtreffen"

    click_on 'Termin anlegen'
    within 'form.new_event' do
      fill_in 'Betreff',      with: event.title
      fill_in 'Beginn',       with: I18n.l(event.start_at.to_date, format: :default)
      fill_in 'Ende',         with: I18n.l(event.end_at.to_date,   format: :default)
      fill_in 'Webseite',     with: event.url
      fill_in 'Beschreibung', with: event.description
      fill_in 'Straße',       with: event.address.street
      fill_in 'Postleitzahl', with: event.address.zip
      fill_in 'Ort',          with: event.address.city
      fill_in 'Land',         with: event.address.country
      click_on 'Termin erstellen'
    end
    expect(page).to have_content 'Dein Motorradtermin wurde erfolgreich gespeichert.'
    expect(page).to have_content event.title
    expect(page).to have_content event.description
    expect(page).to have_content event.url
    expect(page).to have_content I18n.l( event.start_at, format: :longest)
    expect(page).to have_content I18n.l( event.end_at,   format: :longest)
    expect(page).to have_content event.address.street
    expect(page).to have_content event.address.zip
    expect(page).to have_content event.address.city
    expect(page).to have_content event.address.country
    expect(page).to have_content event.user.to_s
  end

  scenario 'I should be able to edit an event' do
    random_event = build :random_event, :with_address
    sign_in user
    event = create :event, user: user

    visit "/motorradtreffen/#{event.slug}"
    click_on 'Termin bearbeiten'
    within 'form.edit_event' do
      fill_in 'Betreff',      with: random_event.title
      fill_in 'Beginn',       with: I18n.l(random_event.start_at.to_date, format: :default)
      fill_in 'Ende',         with: I18n.l(random_event.end_at.to_date,   format: :default)
      fill_in 'Webseite',     with: random_event.url
      fill_in 'Beschreibung', with: random_event.description
      fill_in 'Straße',       with: random_event.address.street
      fill_in 'Postleitzahl', with: random_event.address.zip
      fill_in 'Ort',          with: random_event.address.city
      fill_in 'Land',         with: random_event.address.country
      click_on 'Änderungen speichern'
    end
    expect(page).to have_content 'Dein Termin wurde erfolgreich gespeichert'
    expect(page).to have_content random_event.title
    expect(page).to have_content random_event.description
    expect(page).to have_content random_event.url
    expect(page).to have_content I18n.l( event.start_at, format: :longest)
    expect(page).to have_content I18n.l( event.end_at,   format: :longest)
    expect(page).to have_content random_event.address.street
    expect(page).to have_content random_event.address.zip
    expect(page).to have_content random_event.address.city
    expect(page).to have_content random_event.address.country
  end
end
