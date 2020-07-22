class Post::ActivityService < ActivityBaseService

  private

  def owner
    @object&.poi || @object&.user
  end

  def users
    super + User.near_by(@object, 80).to_a
  end

end
