module Concerns::User::Friends

  extend ActiveSupport::Concern

  included do
    alias_method_chain :approve, :notification
    alias_method_chain :invite,  :notification
  end

  def approve_with_notification(user)
    if result = approve_without_notification(user)
      User::ActivityService.process object: self, on: :create, key: 'user.friendship.approve'

      Notification.fire({
        subject: self,
        type:    'user.friendship.approve',
        users:   user
      })
    end
    result
  end

  def invite_with_notification(user)
    if result = invite_without_notification(user)
      Notification.fire({
        subject: self,
        type:    'user.friendship.invite',
        users:   user
      })
    end
    result
  end

end
