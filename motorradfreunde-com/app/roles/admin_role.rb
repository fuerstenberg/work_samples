class AdminRole < AccessGranted::Role
  def configure
    can :destroy, Article
    can :destroy, Bike
    can :destroy, Comment
    can :destroy, Conversation
    can :destroy, ConversationMembership
    can :destroy, DelayedJobItem
    can :destroy, Event
    can [:create, :update, :destroy], Image
    can :destroy, LinkedArticle
    can :destroy, Message
    can :destroy, Poi
    can :destroy, Post
    can :destroy, RideRequest
    can :destroy, Route
    can [:update, :destroy], User
    can :destroy, Video
  end
end
