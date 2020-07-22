# # encoding: utf-8
# require 'rails_helper'
#
# feature "Routes" do
#   background do
#     logged_in_user
#   end
#
#   #   @javascript
#   scenario "I want to create and edit a route", js: true do
#     visit "/"
#     within ".main-navigation" do
#       click_on "Routen"
#     end
#     within ".title" do
#       expect(page).to have_content "Beliebte Motorradtouren"
#     end
#     within ".main-action" do
#       click_on "Route anlegen"
#     end
#
#     within ".title" do
#       expect(page).to have_content "Neue Route anlegen"
#     end
#
#     find("input#search").set("99988 Heyerode")
#   end
#
# end
