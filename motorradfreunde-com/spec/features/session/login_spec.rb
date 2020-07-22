# encoding: utf-8
require 'rails_helper'

feature 'User login' do
  given!(:user) { FactoryGirl.create(:user, name: 'Homer Simpson') }

  scenario 'as a logged out user' do
    visit '/'
    expect(page).to have_content 'Benutzerkonto erstellen'
    expect(page).to have_content 'Anmelden'
    expect(page).to have_content 'Facebook Login'
    click_link 'Anmelden'
    expect(page).to have_content 'Anmelden (Login)'
    within 'form#new_user' do
      fill_in 'user[email]',    with: user.email
      fill_in 'user[password]', with: 'secret'
      click_button 'Anmelden'
    end

    expect(page).to have_content 'Du hast Dich erfolgreich angemeldet.'
    within '.main-navigation .current_user_name' do
      expect(page).to have_content 'Homer Simpson'
    end
    expect(page).to_not have_content 'Benutzerkonto erstellen'
    expect(page).to_not have_content 'Anmelden'
    expect(page).to_not have_content 'Facebook Login'
  end

end
