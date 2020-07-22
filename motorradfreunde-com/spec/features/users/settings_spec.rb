# encoding: utf-8
require 'rails_helper'

feature 'User settings', js: true do
  before do
    I18n.locale = :de
  end

  given!(:user)    { FactoryGirl.create(:user, name: 'Homer Simpson') }
  given!(:details) { FactoryGirl.build(:user, :details, name: 'Homer J. Simpson') }

  scenario 'change my account settings' do
    sign_in user

    visit edit_user_path(user)

    within 'h1' do
      expect(page).to have_content 'Profil bearbeiten'
    end

    within '.user_name' do
      fill_in 'Name', with: details.name
    end

    within '.user_date_of_birth' do
      fill_in 'Geburtstag', with: I18n.l(details.date_of_birth) # format '13.05.1978'
    end

    within '.user_gender' do
      choose details.gender_text
    end

    # within '.user_email' do
    #   fill_in 'eMail', with: 'marge.simpson@gmail.com'
    # end
    #
    # within '.user_password' do
    #   fill_in 'Passwort', with: 'topsecret'
    #   # fill_in 'user[password]', with: 'topsecret'
    # end
    #
    # within '.user_password_confirmation' do
    #   fill_in 'Passwortwiederholung', with: 'topsecret'
    # end
    #

    within '.user_interested_in_gender' do
      details.interested_in_gender.each do |v|
        check v.text
      end
    end

    within '.user_status_for_relationship' do
      choose details.status_for_relationship_text
    end

    within '.user_status_as_biker' do
      details.status_as_biker.each do |v|
        check v.text
      end
    end

    within '.user_has_own_motorcycle' do
      choose details.has_own_motorcycle_text
    end

    within '.user_status_of_social_behavior' do
      details.status_of_social_behavior.each do |v|
        check v.text
      end
    end

    within '.user_status_for_backseat' do
      choose details.status_for_backseat_text
    end

    within '.user_description' do
      fill_in 'Beschreibung', with: details.description
    end

    within '.user_favourite_experience' do
      fill_in 'Schönste Motorraderfahrung', with: details.favourite_experience
    end

    within '.user_driving_description' do
      fill_in 'Warum fährst Du Motorrad?', with: details.driving_description
    end

    within '.user_favourite_areas' do
      fill_in 'Lieblingsstrecken', with: details.favourite_areas
    end

    within '.user_licence_date' do
      select details.licence_date, from: 'user[licence_date]'
    end

    within '.user_distance_total' do
      select details.distance_total, from: 'user[distance_total]'
    end

    within '.user_distance_per_year' do
      select details.distance_per_year, from: 'user[distance_per_year]'
    end

    within '.user_favorite_vendor' do
      fill_in 'Lieblingshersteller', with: details.favorite_vendor
    end

    within '.user_favorite_engine_amount_of_cylinders' do
      select details.favorite_engine_amount_of_cylinders, from: 'user[favorite_engine_amount_of_cylinders]'
    end

    within '.user_favorite_driving_style' do
      details.favorite_driving_style.each do |v|
        check v.text
      end
    end

    within '.user_favorite_drive_type' do
      details.favorite_drive_type.each do |v|
        check v.text
      end
    end

    within '.user_favorite_clothing' do
      details.favorite_clothing.each do |v|
        check v.text
      end
    end

    within '.actions' do
      click_on 'Änderungen speichern'
    end

    expect(page).to have_content 'Dein Benutzerprofil wurde erfolgreich gespeichert.'
    expect(page).to have_content details.name
    expect(page).to have_content details.age
    expect(page).to have_content details.gender_text
    details.interested_in_gender.each do |v|
      expect(page).to have_content v.text
    end
    expect(page).to have_content details.status_for_relationship_text
    details.status_as_biker.each do |v|
      expect(page).to have_content v.text
    end
    expect(page).to have_content details.has_own_motorcycle_text
    details.status_of_social_behavior.each do |v|
      expect(page).to have_content v.text
    end
    expect(page).to have_content details.status_for_backseat_text
    expect(page).to have_content details.description
    expect(page).to have_content details.favourite_experience
    expect(page).to have_content details.driving_description
    expect(page).to have_content details.favourite_areas
    expect(page).to have_content details.licence_date
    expect(page).to have_content details.distance_total
    expect(page).to have_content details.distance_per_year
    expect(page).to have_content details.favorite_vendor
    expect(page).to have_content details.favorite_engine_amount_of_cylinders
    details.favorite_driving_style.each do |v|
      expect(page).to have_content v.text
    end
    details.favorite_drive_type.each do |v|
      expect(page).to have_content v.text
    end
    details.favorite_clothing.each do |v|
      expect(page).to have_content v.text
    end
  end

end
