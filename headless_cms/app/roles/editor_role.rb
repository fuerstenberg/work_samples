class EditorRole < AccessGranted::Role
  def configure
    # can :read, Article
    # can :read, Bike
    # can :read, Comment
    # can :read, Event
    # can :read, Image
    # can :read, LinkedArticle
    # can :read, Poi
    # can :read, Post
    # can :read, Route
    # can :read, Video
    can :manage, Address
    can :manage, Content
    can :manage, ContentField
    can :manage, ContentField::Base
    can :read, ContentType
    can :read, Customer
    can :manage, Document
    can :manage, Image
    can :manage, Release
    can :read, Role do |object, user|
      object == Role || !(object.god? || object.admin?)
    end
    can :read, Screen
    can :manage, User do |object, user|
      object == User || !object.god?
    end
    can :manage, Video
  end
end
