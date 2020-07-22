namespace :activites do

  desc "Recreate activities"
  task recreate: :environment do
    Comment.where(commentable_type: ["Mootoor", "Mc", "Trip", "Post", nil]).delete_all
    PublicActivity::Activity.delete_all
    [Article,Bike,Event,Poi,Answer,Comment,Photo,Question,RideRequest,Route,User].each do |c|
      c.order(updated_at: :desc).limit(12000).all.each{|o| o.create_activity(:create)}
    end
  end

end
