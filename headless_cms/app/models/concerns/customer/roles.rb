module Concerns::Customer::Roles
  extend ActiveSupport::Concern

  class_methods do
    def without_role_for_user(user)
      all - user.customers
    end
  end

  def admins
    users.and('roles.type': :admin)
  end

  def editors
    users.and('roles.type': :editor)
  end

  def owners
    users.and('roles.type': :owner)
  end

  def users
    User.where('roles.customer_id': id)
  end

end
