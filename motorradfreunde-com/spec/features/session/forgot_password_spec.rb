# encoding: utf-8
require 'rails_helper'

feature 'User forgot password' do
  given!(:user) { FactoryGirl.create(:user, name: 'Homer Simpson') }

  scenario 'as a logged out user' do
    visit '/users/login'
    click_link 'Passwort vergessen?'

    expect(page).to have_content 'Du hast Dein Passwort vergessen?'
    within 'form#new_user' do
      fill_in 'eMail', with: user.email
      click_button 'Passwort senden'
    end

    expect(page).to have_content 'Du bekommst in wenigen Minuten eine eMail in der beschrieben ist, wie Du Dein Passwort ändern kannst.'
  end

end
