module Concerns::User::Greetings

  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
  end

  def greet(user)
    Notification.fire({
      subject: self,
      type:    'user.greet',
      users:   user
    })
  end

end
