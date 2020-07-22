# module Concerns::Activity

#   extend ActiveSupport::Concern

#   included do
#     has_many :commenters, through: :comments, source: :user
#     has_many :activities, as: :trackable, dependent: :destroy

#     after_create :create_activities
#   end

#   def create_activities
#     case self
#     when Answer      then create_activities_for_answer
#     when Article     then create_activities_for_article
#     when Bike        then create_activities_for_bike
#     when Comment     then create_activities_for_comment
#     when Event       then create_activities_for_event
#     when Followship  then create_activities_for_followship
#     when Photo       then create_activities_for_photo
#     when Poi         then create_activities_for_poi
#     when Question    then create_activities_for_question
#     when RideRequest then create_activities_for_ride_request
#     when Route       then create_activities_for_route
#     when User        then create_activities_for_user
#     end
#   end

#   def activity_users
#     users = case self
#     when Answer
#       ([self.question.user] + self.question.commenters + self.question.answerers)
#     when Article
#       ([self.user] + self.commenters + self.user.followers)
#     when Bike
#       ([self.user] + self.commenters + self.user.followers)
#     when Comment
#       ([self.user] + self.commentable.activity_users + self.commenters + (self.user ? self.user.followers: []))
#     when Event
#       ([self.user] + self.commenters + (self.user ? self.user.followers: []) + User.near_by(self, 100))
#     when Followship
#       ([self.user] + self.follower.followers - [self.follower])
#     when Photo
#       ([self.user] + (self.user ? self.user.followers: []))
#     when Poi
#       ([self.user] + (self.user ? self.user.followers: []) + User.near_by(self.user, 50))
#     when Question
#       ([self.user] + self.commenters + self.answerers + (self.user ? self.user.followers: []))
#     when RideRequest
#       ([self.user] + self.commenters + (self.user ? self.user.followers: []) + self.user.similar_users)
#     when Route
#       ([self.user] + self.commenters + (self.user ? self.user.followers: []) + User.near_by(self.user, 50))
#     when User
#       (User.near_by(self, 20) + self.followers - [self])
#     end
#     users.flatten(10).compact.uniq
#   end

#   def create_activities_for_answer
#     self.activity_users.each do |recipient|
#       self.create_activity({
#         key:          'answer.create',
#         owner:        self.user,
#         recipient:    recipient,
#         latitude:     self.user.latitude,
#         longitude:    self.user.longitude,
#         notification: true,
#         trackable:    self.question
#       })
#     end
#   end

#   def create_activities_for_article
#     self.activity_users.each do |recipient|
#       self.create_activity({
#         key:          'article.create',
#         owner:        self.user,
#         recipient:    recipient,
#         latitude:     self.user.latitude,
#         longitude:    self.user.longitude
#       })
#     end
#   end

#   def create_activities_for_bike
#     self.activity_users.each do |recipient|
#       self.create_activity({
#         key:          'bike.create',
#         owner:        self.user,
#         recipient:    recipient,
#         latitude:     self.user.latitude,
#         longitude:    self.user.longitude
#       })
#     end
#   end

#   def create_activities_for_comment
#     # self.activity_users.each do |recipient|
#     #   self.create_activity({
#     #     key:          'bike.create',
#     #     owner:        self.user,
#     #     recipient:    recipient,
#     #     latitude:     self.user.latitude,
#     #     longitude:    self.user.longitude
#     #   })
#     # end
#   end

#   def create_activities_for_event
#     self.activity_users.each do |recipient|
#       self.create_activity({
#         key:          'event.create',
#         owner:        self.user,
#         recipient:    recipient,
#         latitude:     self.latitude,
#         longitude:    self.longitude
#       })
#     end
#   end

#   def create_activities_for_feed_item
#     self.create_activity({
#       key:          'feed_item.create',
#       owner:        self.user,
#       recipient:    self.user,
#       latitude:     self.user.latitude,
#       longitude:    self.user.longitude
#     })
#   end

#   def create_activities_for_followship
#     self.activity_users.each do |recipient|
#       self.create_activity({
#         key:          'followship.create',
#         owner:        self.follower,
#         recipient:    recipient,
#         trackable:    self.user
#       })
#     end
#   end

#   def create_activities_for_photo
#     return true if self.photogenic.is_a?(Route) or self.photogenic.is_a?(Poi)
#     self.activity_users.each do |recipient|
#       self.create_activity({
#         key:          'photo.create',
#         owner:        self.user,
#         recipient:    recipient,
#         trackable:    self
#       })
#     end
#   end

#   def create_activities_for_poi
#     self.activity_users.each do |recipient|
#       self.create_activity({
#         key:          'poi.create',
#         owner:        self.user,
#         recipient:    recipient,
#         latitude:     self.latitude,
#         longitude:    self.longitude
#       })
#     end
#   end

#   def create_activities_for_question
#     self.activity_users.each do |recipient|
#       self.create_activity({
#         key:          'question.create',
#         owner:        self.user,
#         recipient:    recipient,
#         latitude:     self.user.latitude,
#         longitude:    self.user.longitude
#       })
#     end
#   end

#   def create_activities_for_ride_request
#     self.activity_users.each do |recipient|
#       self.create_activity({
#         key:          'ride_request.create',
#         owner:        self.user,
#         recipient:    recipient,
#         latitude:     self.user.latitude,
#         longitude:    self.user.longitude
#       })
#     end
#   end

#   def create_activities_for_route
#     self.activity_users.each do |recipient|
#       self.create_activity({
#         key:          'route.create',
#         owner:        self.user,
#         recipient:    recipient,
#         latitude:     self.latitude,
#         longitude:    self.longitude
#       })
#     end
#   end

#   def create_activities_for_user
#     self.activity_users.each do |recipient|
#       self.create_activity({
#         key:          'user.create',
#         owner:        self,
#         recipient:    recipient,
#         trackable:    self,
#         latitude:     self.latitude,
#         longitude:    self.longitude
#       })
#     end
#   end

# end
