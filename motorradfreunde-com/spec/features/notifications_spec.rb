# # encoding: utf-8
# require 'rails_helper'
#
# feature "Notification" do
#   # background do
#   #   logged_in_user
#   # end
#
# # Feature: Notifications
# #   In order to see notifications
# #   As a logged in user
# #   I want to be able to see unread notfications
#
# scenario "View notification for article created"
# #   Given a user called "Lisa Simpson"
# #     And a logged in user called "Bart Simpson"
# #     And I am following "Lisa Simpson"
# #     And an article with title "Bart nervt" written by "Lisa Simpson"
# #   When  I am on the root page
# #     And I follow "Benachrichtigungen"
# #   Then  I should see "Lisa Simpson hat den Artikel Bart nervt geschrieben."
#
# scenario "View notification for article comments"
# #   Given a logged in user called "Bart Simpson"
# #     And a user called "Marge Simpson"
# #     And an article with title "Lisa nervt" written by "Bart Simpson"
# #     And a comment "Sei nicht so gemein" for article "Lisa nervt" created by "Marge Simpson"
# #   When  I go to the root page
# #     And I follow "Benachrichtigungen"
# #   Then  I should see "Marge Simpson hat den Artikel Lisa nervt kommentiert."
#
# scenario "View notification for bike created"
# #   Given a user called "Lisa Simpson"
# #     And a logged in user called "Bart Simpson"
# #     And I am following "Lisa Simpson"
# #     And a bike created by "Lisa Simpson"
# #   When  I am on the root page
# #     And I follow "Benachrichtigungen"
# #   Then  I should see "Lisa Simpson hat eine BMW K 1200 R zu seinem Profil hinzugefügt."
#
# scenario "View notification for own bike comments"
# #   Given a logged in user called "Bart Simpson"
# #     And a bike created by "Bart Simpson"
# #     And a user called "Lisa Simpson"
# #     And a comment "Tolles Motorrad" for bike created by "Lisa Simpson"
# #   When  I am on the root page
# #     And I follow "Benachrichtigungen"
# #   Then  I should see "Lisa Simpson hat dein Bike BMW K 1200 R kommentiert."
# #   When  I follow "BMW K 1200 R"
# #   Then  I should see "Tolles Motorrad"
#
# scenario "View notification for own bike comments"
# #   Given a logged in user called "Bart Simpson"
# #     And a user called "Lisa Simpson"
# #     And a bike created by "Lisa Simpson"
# #     And a comment "Cooles Bike" for bike created by "Bart Simpson"
# #     And a comment "Danke" for bike created by "Lisa Simpson"
# #   When  I am on the root page
# #     And I follow "Benachrichtigungen"
# #   Then  I should see "Lisa Simpson hat das Bike BMW K 1200 R kommentiert."
# #   When  I follow "BMW K 1200 R"
# #   Then  I should see "Cooles Bike"
# #     And I should see "Danke"
#
# scenario "View notification for event comments"
# #   Given a logged in user called "Bart Simpson"
# #     And a event called "Springfield Ride"
# #     And a user called "Lisa Simpson"
# #     And a comment "Tolles Event" for the event "Springfield Ride"
# #   When  I am on the root page
# #     And I follow "Benachrichtigungen"
# #   Then I should see "Lisa Simpson hat dein Event Springfield Ride kommentiert."
#
#
# end
