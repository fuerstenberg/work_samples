class User::FacebookAvatarDownloadService

  def initialize(user_id:, force: false)
    @user = User.find user_id
    @force = force
    process
  end

  def self.process(user_id:, force: false)
    new user_id: user_id, force: force
  end

  def process
    return if !@user.facebooker? or (@user.avatar_image.present? and !@force)
    if result = @user.facebook_graph.get_picture_data(@user.uid, {}, type: :large) and result['is_silhouette'] != true
      # use another url instead of result['url'] to get a bigger image size
      # image = self.images.build(remote_file_url: result['url'], avatar: true)
      image = @user.images.build remote_file_url: "https://graph.facebook.com/#{@user.uid}/picture?width=2000"
      if image.save validate: false
        image.set_as_avatar
      end
    end
  end

end
