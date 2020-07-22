# # encoding: utf-8
# require 'rails_helper'
#
# feature "Article" do
#   background do
#     logged_in_user
#   end
#
#   scenario "View Public articles" do
#     @article = FactoryGirl.create :article, user: @current_user
#     @article.active = true
#     @article.save
#     visit "/"
#     click_on "News"
#     i_should_see "Motorrad — News"
#     i_should_see @article.title
#     within "h2" do
#       click_on @article.title
#     end
#     i_should_see @article.body
#   end
#
#   scenario "Create an article" do
#     visit "/articles"
#     click_on "Artikel schreiben"
#     fill_in "Titel", with: "Homers best jokes"
#     fill_in "Text",  with: "I hope I did not brain my damage"
#     click_on "Artikel anlegen"
#     i_should_see "Dein Artikel wurde erfolgreich angelegt."
#     i_should_see "Homers best jokes"
#     attach_file 'photo[photo]', 'spec/support/testbild.png'
#     click_on "Bild hochladen"
#     i_should_see "Das Bild wurde erfolgreich gespeichert!"
#     i_should_see "Homers best jokes"
#   end
#
#   scenario "View my own article", js: true do
#     @article = FactoryGirl.create :article, user: @user
#     within ".meta_navigation" do
#       click_on @current_user.to_s
#       click_on "Dein Benutzerkonto"
#     end
#     i_should_see @article.title
#     click_first_link @article.title
#     i_should_see @article.body
#   end
#
#   scenario "View articles of another biker" do
#     @user = FactoryGirl.create :user
#     @article = FactoryGirl.create :article, user: @user
#     @article.user = @user
#     @article.save
#     visit "/users/#{@user.id}"
#     click_first_link @article.title
#     i_should_see @article.title
#     i_should_see @article.body
#   end
#
#   scenario "Edit an article" do
#     @article = FactoryGirl.create :article
#     @article.user = @current_user
#     @article.save
#     visit "/articles/#{@article.id}"
#     click_on "Artikel bearbeiten"
#     fill_in "Titel", with: "Homers best jokes #2"
#     click_on "Artikel speichern"
#     i_should_see "Dein Artikel wurde erfolgreich gespeichert."
#     i_should_see "Homers best jokes #2"
#   end
#
#   scenario "Delete an article" do
#     @article = FactoryGirl.create :article
#     @article.user = @current_user
#     @article.save
#     visit "/articles/#{@article.id}"
#     click_on "Artikel löschen"
#     i_should_see "Dein Artikel wurde gelöscht."
#     i_should_not_see "Homers best jokes"
#   end
#
# end
