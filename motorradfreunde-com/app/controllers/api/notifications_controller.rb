class Api::NotificationsController < ApplicationController

  respond_to :json

  after_filter :mark_as_read

  def index
    respond_with current_user.notifications.unread
  end

  private

  def mark_as_read
    current_user.notifications.limit(5).read!
  end

end
