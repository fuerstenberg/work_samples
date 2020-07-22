# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video do
    sequence(:unique_id)    { |n| "youtube_id_#{n}" }
    sequence(:title)        { |n| "Video title #{n}" }
    active                  true
    author_name             "MyString"
    author_uri              "MyString"
    description             "MyText"
    duration                1
    player_url              "MyString"
    youtube_categories      ["MyText"]
    youtube_rating_average  1.5
    youtube_rating_count    1
    youtube_rating_dislikes 1
    youtube_rating_likes    1
    youtube_video_id        "MyString"
    youtube_view_count      1
  end
end
