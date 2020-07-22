feature 'Bikes', js: true do
  let(:user) { FactoryGirl.create(:user) }

  scenario 'should see all bikes' do
    bikes = create_list :random_bike, 10
    visit '/motorraeder'

    bikes.each do |bike|
      expect(page).to have_content bike.to_s
    end
  end

  scenario 'should see a bike' do
    bike = create :bike

    visit "/motorrad/#{bike.vendor.slug}/#{bike.slug}"
    expect(page).to have_content bike.to_s

    expect(page).to have_content bike.vendor.to_s
    expect(page).to have_content bike.model
    expect(page).to have_content bike.ccm
    expect(page).to have_content bike.hp
    expect(page).to have_content bike.year_of_manufacture
    expect(page).to have_content bike.color
    expect(page).to have_content bike.description
  end

  scenario 'should be able to create a bike' do
    vendor = build :vendor
    bike = build :bike
    sign_in user
    visit "/biker/#{user.slug}"

    within '.bikes' do
      click_on 'Motorrad anlegen'
    end

    within 'h1' do
      expect(page).to have_content 'Motorrad anlegen'
    end
    within 'form#new_bike' do
      select bike.year_of_manufacture, from: 'bike[year_of_manufacture]'
      select vendor.to_s, from: 'bike[poi_id]'
      fill_in 'Modell', with: bike.model
      fill_in 'Hubraum', with: bike.ccm
      fill_in 'Leistung', with: bike.hp
      fill_in 'Farbe', with: bike.color
      fill_in 'Beschreibung', with: bike.description
      click_on 'Motorrad anlegen'
    end

    within 'h1' do
      expect(page).to have_content bike.to_s
    end

    expect(page).to have_content bike.vendor.to_s
    expect(page).to have_content bike.model
    expect(page).to have_content bike.ccm
    expect(page).to have_content bike.hp
    expect(page).to have_content bike.year_of_manufacture
    expect(page).to have_content bike.color
    expect(page).to have_content bike.description
  end

  scenario 'should be able to edit a bike' do
    random_bike = build :random_bike
    bike = create :bike, user: user
    sign_in user

    visit "/motorrad/#{bike.vendor.slug}/#{bike.slug}"
    expect(page).to have_content bike.to_s

    click_on 'Motorrad bearbeiten'
    within 'h1' do
      expect(page).to have_content 'Motorrad bearbeiten'
    end

    within 'form.edit_bike' do
      select random_bike.year_of_manufacture, from: 'bike[year_of_manufacture]'
      select random_bike.vendor.to_s, from: 'bike[poi_id]'
      fill_in 'Modell',       with: random_bike.model
      fill_in 'Hubraum',      with: random_bike.ccm
      fill_in 'Leistung',     with: random_bike.hp
      fill_in 'Farbe',        with: random_bike.color
      fill_in 'Beschreibung', with: random_bike.description
      click_on 'Motorrad speichern'
    end

    expect(page).to have_content random_bike.vendor.to_s
    expect(page).to have_content random_bike.model
    expect(page).to have_content random_bike.ccm
    expect(page).to have_content random_bike.hp
    expect(page).to have_content random_bike.year_of_manufacture
    expect(page).to have_content random_bike.color
    expect(page).to have_content random_bike.description
  end

  scenario 'should be able to delete a bike' do
    bike = create :bike, user: user
    sign_in user

    visit "/motorrad/#{bike.vendor.slug}/#{bike.slug}"
    expect(page).to have_content bike.to_s

    click_on 'Motorrad-Optionen'
    click_on 'Motorrad löschen'
    expect(page).to have_content 'Dein Motorrad wurde gelöscht.'
  end


  scenario 'should see all images on bike page' do
    bike = create :bike, :images, user: user

    sign_in user
    visit "/motorrad/#{bike.vendor.slug}/#{bike.slug}"

    within '.images' do
      bike.images.each do |image|
        expect(page).to have_selector "##{ActionView::RecordIdentifier.dom_id(image)}"
      end
    end
  end


  scenario 'should delete an image on bike page' do
    bike = create :bike, user: user
    image = bike.images.build attributes_for(:image, user: bike.user)
    bike.save

    sign_in user
    visit "/motorrad/#{bike.vendor.slug}/#{bike.slug}"

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

  scenario 'should upload an image on bike page' do
    bike = create :bike, user: user
    # bike = create :bike, :images, user: user

    sign_in user
    visit "/motorrad/#{bike.vendor.slug}/#{bike.slug}"

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
