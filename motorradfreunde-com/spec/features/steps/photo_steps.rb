def some_photos
  3.times do |index|
    FactoryGirl.create :photo, :user => @user, :photogenic => @user
  end
end

def a_avatar
  FactoryGirl.create :photo, :user => @user, :photogenic => @user, :avatar => true
end

def i_should_see_the_nth_photo_as_avatar(index)
  assert @user.photos[index.to_i - 1].url(:limit_800_800) == @user.avatar(:limit_800_800)
end
