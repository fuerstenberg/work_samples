# # encoding: utf-8
# require 'rails_helper'
#
# feature "Comments" do
#   background do
#     logged_in_user
#   end
#
#   scenario "Leave a comment on an article", js: true do
#     @article = FactoryGirl.create :article, active: true
#     # visit "/articles/#{@article.id}"
#     click_link "mehr"
#     click_link "News"
#     click_first_link @article.title
#     i_should_see @article
#     write_a_comment
#   end
#
#   scenario "Leave a comment on an bike", js: true do
#     @bike = FactoryGirl.create :bike
#     visit "/bikes/#{@bike.id}"
#     i_should_see @bike
#     write_a_comment
#   end
#
#   scenario "Leave a comment on an event", js: true do
#     @event = FactoryGirl.create :event
#     visit "/events/#{@event.id}"
#     i_should_see @event
#     write_a_comment
#   end
#
# end
