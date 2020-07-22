def some_bikes
  [:bmw_k, :bmw_s, :bmw_r].each do |factory|
    FactoryGirl.create factory, :user => @user, :photos => [FactoryGirl.create(:photo)]
  end
  Bike.update_all images_count: 1
end

def a_bike
  @bike = FactoryGirl.create :bmw_k, :user => @user
end

def a_bike_with_a_photo
  a_bike
  FactoryGirl.create :photo, :user => @user, :photogenic => @bike
end

def a_bike_created_by(name)
  user = User.where(:name => name).first
  @bike = FactoryGirl.create :bmw_k, :user => user
end

def a_bike_from_manufacturer(vendor_name)
  @bike = FactoryGirl.create :bike, :vendor_name => vendor_name, :user => @user
  FactoryGirl.create :photo, :user => @user, :photogenic => @bike
end
