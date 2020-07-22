feature 'Users index', js: true do
  given!(:homer) { FactoryGirl.create(:user, name: 'Homer Simpson', email: 'homer.simpson@springfield.com' ) }
  given!(:marge) { FactoryGirl.create(:user, name: 'Marge Simpson', email: 'marge.simpson@springfield.com' ) }
  given!(:bart ) { FactoryGirl.create(:user, name: 'Bart Simpson',  email: 'bart.simpson@springfield.com' ) }
  given!(:lisa ) { FactoryGirl.create(:user, name: 'Lisa Simpson',  email: 'lisa.simpson@springfield.com' ) }
  given!(:maggy) { FactoryGirl.create(:user, name: 'Maggy Simpson', email: 'maggy.simpson@springfield.com' ) }

  before do
    sign_in homer
  end

  scenario 'show all users' do
    visit '/'

    within '.main-navigation' do
      click_on 'Biker'
    end

    expect(page).to have_content homer.name
    expect(page).to have_content marge.name
    expect(page).to have_content bart.name
    expect(page).to have_content lisa.name
    expect(page).to have_content maggy.name
  end

  scenario 'filter within 10km' do
    visit '/biker'
    within '.content .filter' do
      click_on "10 km Umkreis"
    end
    expect(page).to have_http_status 200
  end

  scenario 'filter within 20km' do
    visit '/biker'
    within '.content .filter' do
      click_on "20 km Umkreis"
    end
    expect(page).to have_http_status 200
  end

  scenario 'filter within 50km' do
    visit '/biker'
    within '.content .filter' do
      click_on "50 km Umkreis"
    end
    expect(page).to have_http_status 200
  end

  scenario 'order by impressions' do
    visit '/biker'
    within '.content .filter' do
      click_on "Beliebt"
    end
    expect(page).to have_http_status 200
  end

  scenario 'order by images' do
    visit '/biker'
    within '.content .filter' do
      click_on "Meiste Bilder"
    end
    expect(page).to have_http_status 200
  end

  scenario 'show all' do
    visit '/biker'
    within '.content .filter' do
      click_on "Alle"
    end
    within 'h1' do
      expect(page).to have_content 'Motorradfahrer'
    end
  end
end
