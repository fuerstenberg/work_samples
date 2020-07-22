# encoding: utf-8

# require 'rails_helper'

module Capybara
  module Features

    def logged_in_user(name = "Homer Simpson")
      visit "/"
      @user = @current_user = a_user(name)
      visit('/users/login')
      sleep 1
      fill_in("eMail",    with: @current_user.email)
      fill_in("Passwort", with: "secret")
      click_button("Anmelden")
      sleep 1
      i_should_see "Du hast Dich erfolgreich angemeldet."
    end

    def logged_in_admin(name = "Montgomery Burns")
      logged_in_user name
      @user.admin = true
      @user.save validate: false
      visit "/"
      # visit "/"
      # current_user = a_admin name
      # visit('/users/login')
      # fill_in("eMail",    with: current_user.email)
      # fill_in("Passwort", with: "secret")
      # # click_button("Anmelden")
      # find('input.btn.btn-primary').click
      # @user = @current_user = current_user
    end

    def a_user(name)
      @user = @current_user = FactoryGirl.create(:user, name: name)
    end

    def a_admin(name = "Montgomery Burns")
      unless user = User.find_by_name(name)
        user = FactoryGirl.create(:user, name: name)
      end
      user.admin = true
      user.save validate: false
      @user = @current_user = user
    end


    def a_user_with_a_photo_called(name)
      a_user name
      @user.photos << FactoryGirl.create(:photo)
    end

    def a_user_with_a_photo_and_some_points_and_created_some_days_ago(name, points, days)
      a_user_with_a_photo_called name
      @user.update_column(:points, points.to_i)
      @user.update_column(:created_at, Time.now - days.to_i.days)
    end

  end
end
