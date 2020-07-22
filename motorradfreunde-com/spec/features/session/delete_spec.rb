# encoding: utf-8
require 'rails_helper'

feature 'User delete', js: true do
  given!(:user) { FactoryGirl.create(:homer) }

  scenario 'as a logged in user' do
    sign_in user

    visit "/biker/#{user.slug}/edit"
    click_link 'Mitgliedschaft beenden'

    # accept_prompt do
    #   # click_link('Show Alert')
    #   click_link 'Benutzerkonto löschen'
    # end
    click_link 'Benutzerkonto löschen'

    expect(page).to have_content 'Schade! Dein Benutzerkonto wurde erfolgreich gelöscht. Wir hoffen, dass wir Dich hier bald wiedersehen.'
  end

end
