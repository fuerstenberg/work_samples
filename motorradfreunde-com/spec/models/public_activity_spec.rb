# describe PublicActivity::Activity do
#   let(:user         ) { create :user, :friend, :neighbours }
#   let(:involved_user) { create :user } # needs an address not in my neighborhood
#
#   before(:all) do
#     ActivityBaseService.enabled = true
#   end
#
#   context 'Bike' do
#     context 'if I create a bike' do
#       let(:bike) { build :bike, user: user }
#
#       it 'should return an activity for me' do
#         expect {
#           bike.save
#         }.to change {
#           PublicActivity::Activity.where(key: 'bike.create', owner: bike.user).count
#         }.by 1
#         newest_activity = user.public_activities.first
#         expect(newest_activity.key      ).to eq 'bike.create'
#         expect(newest_activity.trackable).to eq bike
#         expect(newest_activity.owner    ).to eq user
#       end
#
#       it 'should return an activity for my friends' do
#         PublicActivity.with_tracking do
#           bike.save
#         end
#         expect(user.friends.count).to be > 0
#         user.friends.each do |friend|
#           newest_activity = friend.public_activities.first
#           expect(newest_activity.key      ).to eq 'bike.create'
#           expect(newest_activity.trackable).to eq bike
#           expect(newest_activity.owner    ).to eq user
#         end
#       end
#     end
#   end
#
#   context 'Comment' do
#     context 'if I create a comment' do
#       let(:bike)    { create :bike }
#       let(:comment) { build :comment, commentable: bike }
#
#       it 'should return an activity for me' do
#         PublicActivity.with_tracking do
#           comment.save
#         end
#         newest_activity = user.public_activities.first
#         expect(newest_activity.key           ).to eq 'comment.create'
#         expect(newest_activity.parent        ).to eq comment.commentable
#         expect(newest_activity.trackable_id  ).to eq comment.id # can`t reference, because the comment is nested to the parent
#         expect(newest_activity.trackable_type).to eq 'Comment'
#         expect(newest_activity.owner         ).to eq user
#       end
#
#       it 'should return an activity for my friends' do
#         PublicActivity.with_tracking do
#           comment.save
#         end
#         expect(user.friends.count).to be > 0
#         user.friends.each do |friend|
#           newest_activity = friend.public_activities.first
#           expect(newest_activity.key           ).to eq 'comment.create'
#           expect(newest_activity.parent        ).to eq comment.commentable
#           expect(newest_activity.trackable_id  ).to eq comment.id # can`t reference, because the comment is nested to the parent
#           expect(newest_activity.trackable_type).to eq 'Comment'
#           expect(newest_activity.owner    ).to eq user
#         end
#       end
#     end
#   end
#
#   context 'Event' do
#     context 'if I create an event' do
#       let(:event) { build :event, user: user }
#
#       it 'should return an activity for me' do
#         PublicActivity.with_tracking do
#           event.save
#         end
#         newest_activity = user.public_activities.first
#         expect(newest_activity.key      ).to eq 'event.create'
#         expect(newest_activity.trackable).to eq event
#         expect(newest_activity.owner    ).to eq user
#       end
#
#       it 'should return an activity for my friends' do
#         PublicActivity.with_tracking do
#           event.save
#         end
#         expect(user.friends.count).to be > 0
#         user.friends.each do |friend|
#           newest_activity = friend.public_activities.first
#           expect(newest_activity.key      ).to eq 'event.create'
#           expect(newest_activity.trackable).to eq event
#           expect(newest_activity.owner    ).to eq user
#         end
#       end
#     end
#   end
#
#   context 'Friendship' do
#     context 'if I create a friendship'
#   end
#
#   context 'Image' do
#     context 'if I create a image' do
#       let(:bike)  { create :bike }
#       let(:image) { build :image, imageable: bike }
#
#       it 'should return an activity for me' do
#         PublicActivity.with_tracking do
#           image.save
#         end
#         newest_activity = user.public_activities.detect{ |activity| activity.key == 'image.create' }
#         expect(newest_activity.key           ).to eq 'image.create'
#         expect(newest_activity.parent        ).to eq image.imageable
#         expect(newest_activity.trackable_id  ).to eq image.id # can`t reference, because the image is nested to the parent
#         expect(newest_activity.trackable_type).to eq 'Image'
#         expect(newest_activity.owner         ).to eq user
#       end
#
#       it 'should return an activity for my friends' do
#         PublicActivity.with_tracking do
#           image.save
#         end
#         expect(user.friends.count).to be > 0
#         user.friends.each do |friend|
#           newest_activity = user.public_activities.detect{ |activity| activity.key == 'image.create' and activity.owner == image.user }
#           expect(newest_activity.key      ).to eq 'image.create'
#           expect(newest_activity.parent        ).to eq image.imageable
#           expect(newest_activity.trackable_id  ).to eq image.id # can`t reference, because the image is nested to the parent
#           expect(newest_activity.trackable_type).to eq 'Image'
#           expect(newest_activity.owner    ).to eq user
#         end
#       end
#     end
#   end
#
#   context 'Poi' do
#     context 'if I create a poi' do
#       let(:poi) { build :poi, creator: user }
#
#       it 'should return an activity for me' do
#         PublicActivity.with_tracking do
#           poi.save
#         end
#         newest_activity = user.public_activities.first
#         expect(newest_activity.key      ).to eq 'poi.create'
#         expect(newest_activity.trackable).to eq poi
#         expect(newest_activity.owner    ).to eq user
#       end
#
#       it 'should return an activity for my friends' do
#         PublicActivity.with_tracking do
#           poi.save
#         end
#         expect(user.friends.count).to be > 0
#         user.friends.each do |friend|
#           newest_activity = friend.public_activities.first
#           expect(newest_activity.key      ).to eq 'poi.create'
#           expect(newest_activity.trackable).to eq poi
#           expect(newest_activity.owner    ).to eq user
#         end
#       end
#     end
#   end
#
#   context 'RideRequest' do
#     context 'if I create a ride request' do
#       let(:ride_request) { build :ride_request, user: user }
#
#       it 'should return an activity for me' do
#         PublicActivity.with_tracking do
#           ride_request.save
#         end
#         newest_activity = user.public_activities.first
#         expect(newest_activity.key      ).to eq 'ride_request.create'
#         expect(newest_activity.trackable).to eq ride_request
#         expect(newest_activity.owner    ).to eq user
#       end
#
#       it 'should return an activity for my friends' do
#         PublicActivity.with_tracking do
#           ride_request.save
#         end
#         expect(user.friends.count).to be > 0
#         user.friends.each do |friend|
#           newest_activity = friend.public_activities.first
#           expect(newest_activity.key      ).to eq 'ride_request.create'
#           expect(newest_activity.trackable).to eq ride_request
#           expect(newest_activity.owner    ).to eq user
#         end
#       end
#     end
#   end
#
#   context 'Route' do
#     context 'if I create a route' do
#       let(:route) { build :route, user: user }
#
#       it 'should return an activity for me' do
#         PublicActivity.with_tracking do
#           route.save
#         end
#         newest_activity = user.public_activities.first
#         expect(newest_activity.key      ).to eq 'route.create'
#         expect(newest_activity.trackable).to eq route
#         expect(newest_activity.owner    ).to eq user
#       end
#
#       it 'should return an activity for my friends' do
#         PublicActivity.with_tracking do
#           route.save
#         end
#         expect(user.friends.count).to be > 0
#         user.friends.each do |friend|
#           newest_activity = friend.public_activities.first
#           expect(newest_activity.key      ).to eq 'route.create'
#           expect(newest_activity.trackable).to eq route
#           expect(newest_activity.owner    ).to eq user
#         end
#       end
#     end
#   end
#
#   context 'User' do
#     context 'if I create my user account' do
#       it 'should return an activity for me' do
#         new_user = nil
#         PublicActivity.with_tracking do
#           new_user = create :user, :friend, :neighbours
#         end
#         # needed to detect the correct activity, because FactoryGirl creates the friend
#         # after creating the user, so that the friend-'user.create'-activity is created after my activity
#         newest_activity = new_user.public_activities.detect{ |activity| activity.key == 'user.create' and activity.owner == new_user }
#         expect(newest_activity.key).to eq 'user.create'
#         expect(newest_activity.trackable).to eq new_user
#         expect(newest_activity.owner    ).to eq new_user
#       end
#
#       it 'should return an activity for my friends' do
#         new_user = nil
#         PublicActivity.with_tracking do
#           new_user = create :user, :friend, :neighbours
#         end
#         expect(new_user.friends.count).to be > 0
#         new_user.friends.each do |friend|
#           # needed to detect the correct activity, because FactoryGirl creates the friend
#           # after creating the user, so that the friend-'user.create'-activity is created after my activity
#           newest_activity = friend.public_activities.detect{ |activity| activity.key == 'user.create' and activity.owner == new_user }
#           expect(newest_activity.key).to eq 'user.create'
#           expect(newest_activity.trackable).to eq new_user
#           expect(newest_activity.owner    ).to eq new_user
#         end
#       end
#     end
#
#     context 'if I update my user account' do
#       let(:new_user) { create :user, :friend, :neighbours }
#
#       it 'should return an activity for me' do
#         new_user.name = 'My new name'
#         PublicActivity.with_tracking do
#           new_user.save
#         end
#         newest_activity = new_user.public_activities.first
#         expect(newest_activity.key           ).to eq 'user.update'
#         expect(newest_activity.trackable     ).to eq new_user
#         expect(newest_activity.owner         ).to eq new_user
#         expect(newest_activity.changed_fields).to eq({"name" => ["Homer Simpson", "My new name"]})
#       end
#
#       it 'should return an activity for my friends' do
#         new_user.name = 'My new name'
#         PublicActivity.with_tracking do
#           new_user.save
#         end
#         expect(new_user.friends.count).to be > 0
#         new_user.friends.each do |friend|
#           newest_activity = friend.public_activities.first
#           expect(newest_activity.key           ).to eq 'user.update'
#           expect(newest_activity.trackable     ).to eq new_user
#           expect(newest_activity.owner         ).to eq new_user
#           expect(newest_activity.changed_fields).to eq({"name" => ["Homer Simpson", "My new name"]})
#         end
#       end
#     end
#
#     context 'if I approve a friend invite' do
#       let(:homer) { create :homer }
#       let(:marge) { create :marge }
#
#       it 'should return an activity for me' do
#         PublicActivity.with_tracking do
#           expect{ homer.invite  marge }.to change{ homer.activities.count }.by 0
#           expect{ marge.approve homer }.to change{ marge.activities.where(key: 'user.friendship.approve', owner: homer).count }.by 1
#         end
#       end
#     end
#   end
# end
