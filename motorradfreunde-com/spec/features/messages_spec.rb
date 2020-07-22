feature 'Messages', js: true do
  let(:homer) { FactoryGirl.create(:homer) }
  let(:marge) { FactoryGirl.create(:marge) }

  scenario 'Homer should be able to see empty messages page' do
    sign_in homer
    visit '/conversations'
    expect(page).to have_content 'Deine privaten Nachrichten'
    expect(page).to_not have_selector 'ul.contacts li'
  end

  scenario 'Homer should be able to write a message to Marge' do
    sign_in homer
    visit "/biker/#{marge.slug}"
    click_on 'Nachricht senden'

    within 'form.new_message' do
      fill_in 'message[body]', with: 'I love you!'
      click_on 'Nachricht senden'
    end
    expect(page).to have_content 'Deine Nachricht wurde erfolgreich versendet.'

    within '.chats__messages-list' do
      expect(page).to have_content 'I love you!'
    end
  end

  scenario 'Marge should be able to reply to a message from Homer' do
    conversation = create :conversation
    message = create :message, conversation: conversation, body: 'I love you!'
    homer = conversation.members[0]
    marge = conversation.members[1]
    sign_in marge
    visit "/conversations/#{conversation.id.to_s}/messages"

    within '.chats__messages-list' do
      expect(page).to have_content 'I love you!'
    end
    within 'form.new_message' do
      fill_in 'message[body]', with: 'I love you too!'
      click_on 'Nachricht senden'
    end
    expect(page).to have_content 'Deine Nachricht wurde erfolgreich versendet.'

    within '.chats__messages-list' do
      expect(page).to have_content 'I love you!'
      expect(page).to have_content 'I love you too!'
    end

    sign_in homer
    visit "/conversations/#{conversation.id.to_s}/messages"
    within '.chats__messages-list' do
      expect(page).to have_content 'I love you!'
      expect(page).to have_content 'I love you too!'
    end
  end
end
