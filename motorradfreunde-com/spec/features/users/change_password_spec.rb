# encoding: utf-8
require 'rails_helper'

feature 'Change password', js: true do
  before do
    I18n.locale = :de
  end

  let(:old_password) { 'old_password' }
  let(:new_password) { 'new_password' }

  given!(:user)    { FactoryGirl.create(:user, name: 'Homer Simpson', password: old_password, password_confirmation: old_password) }

  scenario 'change my account settings' do
    sign_in user

    visit password_edit_users_path

    within 'h1' do
      expect(page).to have_content 'Passwort ändern'
    end

    fill_in 'Altes Passwort', with: old_password
    fill_in 'Passwort', with: new_password
    fill_in 'Passwortwiederholung', with: new_password

    within '.actions' do
      click_on 'Passwort ändern'
    end

    fill_in 'eMail', with: user.email
    fill_in 'Passwort', with: new_password
    click_on 'Anmelden'

    expect(page).to have_content 'Du hast Dich erfolgreich angemeldet.'
  end

end
