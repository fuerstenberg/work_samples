feature 'User show', js: true do
  given!(:homer) { FactoryGirl.create(:user, name: 'Homer Simpson', email: 'homer.simpson@springfield.com' ) }
  given!(:marge) { FactoryGirl.create(:user, :bikes, name: 'Marge Simpson' ) }

  scenario 'should redirect to login page as anonymous user' do
    visit "/biker/#{marge.slug}"
    expect(page.current_path).to eq '/users/login'
  end

  scenario 'order by impressions' do
    sign_in homer
    visit "/biker/#{marge.slug}"
    expect(page.current_path).to eq "/biker/#{marge.slug}"
    expect(page).to have_http_status 200
  end

  scenario 'show bikes' do
    sign_in homer
    visit "/biker/#{marge.slug}"

    marge.bikes.each do |bike|
      expect(page).to have_content bike.to_s
    end
  end

  scenario 'should see all images on user profile page' do
    user = create(:user, :images)

    sign_in user
    visit "/biker/#{user.slug}"

    within '.images' do
      user.images.each do |image|
        expect(page).to have_selector "##{ActionView::RecordIdentifier.dom_id(image)}"
      end
    end
  end

  scenario 'should delete an image on user profile page' do
    user = create(:user)
    image = user.images.build attributes_for(:image)
    user.save

    sign_in user
    visit "/biker/#{user.slug}"

    within '.images' do
      expect(page).to have_selector "##{ActionView::RecordIdentifier.dom_id(image)}"
    end

    within '.images' do
      find('.image').hover
      find('a.image__btn-delete').click
    end

    expect(page).to have_content 'Das Bild wurde erfolgreich gelöscht!'

    within '.images' do
      expect(page).to_not have_selector "##{ActionView::RecordIdentifier.dom_id(image)}"
    end
  end

  scenario 'should upload an image on user profile page' do
    user = create(:user, :images)

    sign_in user
    visit "/biker/#{user.slug}"

    within 'form#new_image' do
      attach_file 'image[file]', 'spec/support/testbild.png'
      click_on 'Bild hochladen'
    end

    within '.images' do
      user.images.each do |image|
        expect(page).to have_selector "##{ActionView::RecordIdentifier.dom_id(image)}"
      end
    end
  end
end
