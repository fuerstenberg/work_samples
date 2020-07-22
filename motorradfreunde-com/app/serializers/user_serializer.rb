class UserSerializer < MapItemSerializer

  attributes :name, :is_facebooker, :unread_notifications

  def is_facebooker
    object&.facebooker?
  end

  # def object_type
  #   if object.id == @instance_options[:current_user_id]
  #     "CurrentUser"
  #   else
  #     "User"
  #   end
  # end

  def unread_notifications
    object.notifications.unread.count
  end

  def url
    "/biker/#{object.slug}"
  end

end
