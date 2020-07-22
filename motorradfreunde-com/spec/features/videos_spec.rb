feature 'Videos', js: true do
  let(:video) { FactoryGirl.create(:video) }

  scenario 'I should see all videos' do
    videos = create_list :video, 10

    visit '/motorradvideos'
    expect(videos.count).to eq 10
    videos.each do |video|
      expect(page).to have_content video.to_s
    end
  end

  scenario 'I should see a video' do
    video = create :video
    visit "/motorradvideos/#{video.slug}"
    expect(page).to have_content video.title
    expect(page).to have_content video.description
  end
end
