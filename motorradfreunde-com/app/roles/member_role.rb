class MemberRole < AccessGranted::Role
  def configure
    can [:update, :destroy], Article do |object, user|
      object.user == user
    end

    can :create, Bike
    can [:update, :destroy], Bike do |object, user|
      object.user == user
    end

    can :create, Comment
    can [:update, :destroy], Comment do |object, user|
      object.user == user
    end

    can :read, Conversation do |object, user|
      object.has_member? user
    end
    can [:create, :update], Conversation

    # can :read, :create, :update, :destroy, ConversationMembership

    can :create, Event
    can [:update, :destroy], Event do |object, user|
      object.user == user
    end

    can [:create, :update, :destroy], Image do |object, user|
      if object&.imageable.is_a?(User)
        object&.imageable == user
      else
        object&.imageable&.user == user
      end
    end

    can [:read, :create], Message do |object, user|
      object&.conversation&.has_member? user
    end

    can [:update, :destroy], Message do |object, user|
      object.sender == user
    end

    can :create, Poi
    can :update, Poi do |object, user|
      object.creator == user or
      object.editor == user or
      object.owner == user
    end
    can :destroy, Poi do |object, user|
      object.creator == user or
      object.owner == user
    end

    can :create, Post
    can [:update, :destroy], Post do |object, user|
      object.user == user
    end

    can :read, RideRequest
    can :create, RideRequest
    can [:update, :destroy], RideRequest do |object, user|
      object.user == user
    end

    can :create, Route
    can [:update, :destroy], Route do |object, user|
      object.user == user
    end

    can :read, User
    can [:update, :destroy], User do |object, user|
      object == user
    end
  end
end
