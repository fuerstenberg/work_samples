class AdminRole < AccessGranted::Role
  def configure
    can :manage, Address
    can :manage, Content
    can :manage, ContentField
    can :manage, ContentField::Base
    can :manage, ContentList
    can :manage, ContentTree
    can :manage, ContentType
    can :manage, Customer
    can :manage, Document
    can :manage, Doorkeeper::Application
    can :manage, Image
    can :manage, Release
    can :manage, Role do |object, user|
      object == Role || !(object.god? || object.admin?)
    end
    can :manage, Screen
    can :manage, User do |object, user|
      object == User || !object.god?
    end
    can :manage, Video
  end
end
