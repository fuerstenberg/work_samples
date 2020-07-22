feature 'User friends', js: true do
  given!(:bart)   { FactoryGirl.create(:bart ) }
  given!(:nelson) { FactoryGirl.create(:nelson ) }

  scenario 'should see all friends on profile page' do
    user = create :user, :friends
    sign_in user
    visit "/biker/#{user.slug}"

    within '.friends' do
      user.friends.each do |friend|
        expect(page).to have_content friend.to_s
      end
    end
  end

  scenario 'should invite an user' do
    bart.delete_all_friendships
    sign_in bart
    visit "/biker/#{nelson.slug}"
    click_on 'Freund hinzufügen'

    expect(page).to have_content "Du hast #{nelson} eine Freundschaftsanfrage gesendet."
  end

  scenario 'should approve an user invitation' do
    bart.delete_all_friendships
    bart.invite nelson
    sign_in nelson
    visit "/biker/#{bart.slug}"

    click_on 'Freundschaft annehmen'
    expect(page).to have_content "Du bist jetzt mit #{bart} befreundet."
  end

  scenario 'should remove an user invitation' do
    bart.delete_all_friendships
    bart.invite nelson
    nelson.approve bart
    sign_in bart
    visit "/biker/#{nelson.slug}"

    click_on 'Freundschaft beenden'
    expect(page).to have_content "Du bist jetzt nicht mehr mit #{nelson} befreundet."
  end
end
