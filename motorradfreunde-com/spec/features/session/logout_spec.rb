# encoding: utf-8
require 'rails_helper'

feature "User logout" do
  given!(:user) { FactoryGirl.create(:user, name: 'Homer Simpson') }

  scenario "logout a logged in user" do
    sign_in user

    visit '/'
    click_link "Abmelden"
    expect(page).to have_content 'Du hast Dich abgemeldet.'
  end

end
