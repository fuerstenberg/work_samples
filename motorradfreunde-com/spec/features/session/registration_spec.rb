# encoding: utf-8
require 'rails_helper'

feature 'User registration', js: true do
  given!(:user) { FactoryGirl.build(:user, name: 'Homer Simpson') }

  scenario 'as a logged out user' do
    visit '/'

    within '.site-wrapper' do
      click_link 'Benutzerkonto erstellen'
    end
    expect(page).to have_content 'Benutzerkonto erstellen'
    within 'form#new_user' do
      fill_in 'Name',  with: user.name
      fill_in 'eMail', with: user.email
      # fill_in 'Passwort', with: 'secret'
      fill_in 'user[password]', with: 'secret'
      fill_in 'Passwortwiederholung', with: 'secret'
      check 'Ich akzeptiere die Allgemeinen Geschäftsbedingungen'
      click_button 'Benutzerkonto erstellen'
    end

    expect(page).to have_content 'Willkommen bei motorradfreunde.com! Du hast Dich erfolgreich registriert.'
  end

end
