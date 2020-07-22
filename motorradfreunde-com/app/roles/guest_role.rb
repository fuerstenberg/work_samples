class GuestRole < AccessGranted::Role
  def configure
    can :read, Article
    can :read, Bike
    can :read, Comment
    can :read, Event
    can :read, Image
    can :read, LinkedArticle
    can :read, Poi
    can :read, Post
    can :read, Route
    can :read, Video
  end
end
