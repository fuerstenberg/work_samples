module Concerns::User::Notifications

  extend ActiveSupport::Concern

  included do
    has_many :notifications,            dependent: :destroy
    has_many :notifications_as_subject, dependent: :destroy, class_name: 'Notification', as: :subject
  end

end
