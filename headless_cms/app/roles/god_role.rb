class GodRole < AccessGranted::Role
  def configure
    can :manage, Address
    can :manage, Content
    can :manage, ContentField
    can :manage, ContentList
    can :manage, ContentTree
    can :manage, ContentType
    can :manage, Customer
    can :manage, Document
    can :manage, Doorkeeper::Application
    can :manage, GlobalContentType
    can :manage, Image
    can :manage, Release
    can :manage, Role
    can :manage, Screen
    can :manage, User
    can :manage, Video
  end
end
