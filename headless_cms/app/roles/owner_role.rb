class OwnerRole < AccessGranted::Role
  def configure
    can :manage, Address do |object, user|
      Current.customer == object.try(:customer)
    end

    can :manage, Content do |object, user|
      Current.customer == object.try(:customer)
    end

    can :manage, ContentList do |object, user|
      Current.customer == object.try(:customer)
    end

    can :manage, ContentField::Base do |object, user|
      Current.customer == object.try(:customer)
    end

    can :manage, ContentType do |object, user|
      Current.customer == object.try(:customer)
    end

    can :read, Customer do |object, user|
      Current.customer == object
    end

    can :manage, Document do |object, user|
      Current.customer == object.try(:customer)
    end

    can :manage, Image do |object, user|
      Current.customer == object.try(:customer)
    end

    can :manage, Release do |object, user|
      Current.customer == object.try(:customer)
    end

    can :read, Role do |object, user|
      Current.customer == object.try(:customer)
    end

    can [:create, :update, :destroy], Role do |object, user|
      Current.customer == object.try(:customer) && object.try(:user) != user
    end

    can :read, Screen do |object, user|
      Current.customer == object.try(:customer)
    end

    can :manage, User do |object, user|
      object == User || Current.customer.users.include?(object)
    end

    can :manage, Video do |object, user|
      Current.customer == object.try(:customer)
    end
  end
end
