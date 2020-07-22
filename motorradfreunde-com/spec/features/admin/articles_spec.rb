# # encoding: utf-8
# require 'rails_helper'
#
# feature "Admin articles" do
#
#   background do
#     logged_in_admin
#     @article = FactoryGirl.create :article, title: "Rückrufaktion bei Triumph"
#     visit "/admin/articles"
#     i_should_see @article.title
#   end
#
#   scenario "should be able to edit articles", js: true do
#     within first(".media_article") do
#       click_link "bearbeiten"
#     end
#     fill_in "Titel", with: "Homer goes to Moe's"
#     fill_in "Text", with: "this could be a long story"
#     click_on "Speichern"
#     i_should_see "Artikel wurde aktualisiert."
#     i_should_see "Homer goes to Moe's"
#     i_should_see "this could be a long story"
#   end
#
#   scenario "should be able to activate and deactivate articles" do
#     i_should_see "ist inaktiv"
#     click_on "aktivieren"
#     i_should_see "ist aktiv"
#   end
#
#   scenario "should be able to delete articles" do
#     i_should_see @article.title
#     click_on "löschen"
#     i_should_not_see @article.title
#   end
# end
