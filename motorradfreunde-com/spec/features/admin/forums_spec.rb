# # encoding: utf-8
# require 'rails_helper'
#
# feature "Admin forums" do
#
#   background do
#     logged_in_admin
#     visit "/admin/forums"
#   end
#
#   scenario "should create, update forums", js: true do
#     fill_in "Name", with: "Allgemeines"
#     fill_in "Beschreibung", with: "Allgemeine Motorradthemen"
#     click_on "Forum anlegen"
#     i_should_see "Allgemeines"
#     question = FactoryGirl.create :question, forum_id: Forum.first.id, title: "Wohin fahren wir?"
#     forum = FactoryGirl.create :forum, name: "BMW"
#     first(:link, "Allgemeines").click
#
#     i_should_see "Wohin fahren wir?"
#
#     first("select.forum_selector").select "BMW"
#
#     i_should_not_see "Wohin fahren wir?"
#   end
#
# end
