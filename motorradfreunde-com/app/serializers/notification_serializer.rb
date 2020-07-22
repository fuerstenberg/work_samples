class NotificationSerializer < ActiveModel::Serializer

  # self.root = false

  attributes :id, :subject_id, :subject_type, :notification_type, :parent_id, :parent_type, :user_id

  def id
    object.id.to_s
  end

end
