class Comment::ActivityService < ActivityBaseService

  private

  def parent
    if @object.commentable.is_a?(Comment)
      @object.commentable&.commentable
    else
      @object.commentable
    end
  end

  def users
    super + [ @object&.commentable&.user, @object&.commentable&.commenters ]
  end

end
