# # encoding: utf-8
# require 'rails_helper'
#
# feature "Question" do
#   background do
#     logged_in_user
#     @forum = FactoryGirl.create :forum, name: "Allgemein"
#   end
#
#   scenario "Ask a question" do
#     visit "/"
#     click_on_first "Forum"
#     click_on "Neuer Eintrag"
#     i_should_see "Neuer Foreneintrag"
#     first("select#question_forum_id").select "Allgemein"
#     fill_in "Deine Frage", with: "Sollte ich eine Harley kaufen?"
#     fill_in "Beschreibung", with: "Die glänzen sooo schön."
#     click_on "Eintrag speichern"
#     i_should_see "Dein Eintrag wurde erfolgreich gespeichert. Andere Biker können darauf antworten."
#     i_should_see "Sollte ich eine Harley kaufen?"
#     i_should_see "Die glänzen sooo schön."
#     i_should_see "0 Antworten"
#   end
#
#   scenario "Ask a question in a forum without selecting it in the question form" do
#     visit "/forums/#{@forum.id}/questions"
#     click_on "Neuer Eintrag"
#     i_should_see "Neuer Foreneintrag in Allgemein"
#     fill_in "Deine Frage", with: "Sollte ich eine BMW kaufen?"
#     fill_in "Beschreibung", with: "Die glänzen sooo schön."
#     click_on "Eintrag speichern"
#     i_should_see "Dein Eintrag wurde erfolgreich gespeichert. Andere Biker können darauf antworten."
#     i_should_see "Sollte ich eine BMW kaufen?"
#     i_should_see "Die glänzen sooo schön."
#     i_should_see "0 Antworten"
#   end
#
#   scenario "Answer a question", js: true do
#     @question = FactoryGirl.create :question, forum: @forum
#     # visit "questions/#{@question.id}"
#     within ".main-navigation" do
#       click_link "Forum"
#     end
#
#     click_first_link @question
#
#     i_should_see @question
#     fill_in "Deine Antwort", with: "No"
#     within ".new_answer" do
#       click_on "Antworten"
#     end
#     i_should_see "Deine Antwort wurde erfolgreich gespeichert."
#     i_should_see @question
#     i_should_see "No"
#     sleep 4
#     # click_link "Kommentieren"
#     fill_in "comment_body", with: "Mach es doch einfach..."
#     # find("#comment_body").first.set "Mach es doch einfach..."
#     click_on "Kommentar anlegen"
#     i_should_see "Mach es doch einfach..."
#   end
#
# end
