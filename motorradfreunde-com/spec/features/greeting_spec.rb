feature 'Greeting', js: true do
  let(:homer) { FactoryGirl.create(:user, :with_address, name: 'Homer Simpson') }
  let(:marge) { FactoryGirl.create(:user, :with_address, name: 'Marge Simpson') }

  xscenario 'should be able to greet biker from bikers index page', js: true do
    sign_in marge
    visit '/biker'
    selector = "#card_user_#{homer.id.to_s}"

    find(selector).hover
    within selector do
      expect(page).to have_content homer.name
      click_on 'Bikergruß senden'
    end
    expect(page).to have_content 'Du hast den Biker ganz lässig im Vorbeifahren gegrüßt.'
  end

  scenario 'should be able to greet biker from bikers show page' do
    sign_in homer
    visit "/biker/#{marge.slug}"
    click_on 'Bikergruß senden'
    expect(page).to have_content 'Du hast den Biker ganz lässig im Vorbeifahren gegrüßt.'
  end

end
