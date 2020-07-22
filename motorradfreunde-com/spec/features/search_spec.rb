feature 'Search', js: true do
  let(:bike)   { FactoryGirl.create :bike   }
  let(:event)  { FactoryGirl.create :event  }
  let(:poi)    { FactoryGirl.create :poi    }
  let(:route)  { FactoryGirl.create :route  }
  let(:vendor) { FactoryGirl.create :vendor }
  let(:video)  { FactoryGirl.create :video  }
  let(:user)   { FactoryGirl.create :user   }

  scenario 'should search in all models' do
    visit '/'
    [
      bike,
      event,
      poi,
      route,
      vendor,
      video,
      user,
    ].each do |object|
      within 'form.search' do
        # fill_in 'Suche', with: object.to_s
        fill_in 'search[query]', with: object.to_s
        # click_on 'Submit Search'
        page.execute_script("$('form.search').submit()")
      end

      within '.content' do
        expect(page).to have_content object.to_s
      end
    end
  end
end
