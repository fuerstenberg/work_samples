class ModeratorRole < AccessGranted::Role
  def configure
    can [:update, :destroy], Article
    can [:update, :destroy], Bike
    can [:update, :destroy], Comment
    can [:update, :destroy], Event

    can [:create, :update, :destroy], Image do |object, user|
      object&.imageable.is_a?(Poi)
    end

    # can :create, :update, :destroy, LinkedArticle
    # can :create, :update, :destroy, Message
    can [:update, :destroy], Poi
    can :destroy, Post
    can :destroy, RideRequest
    can [:update, :destroy], Route
    can [:create, :update, :destroy], Video
  end
end
