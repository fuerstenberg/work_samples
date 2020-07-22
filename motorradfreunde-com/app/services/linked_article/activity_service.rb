class LinkedArticle::ActivityService < ActivityBaseService

  private

  def owner
    @object&.poi
  end

  def users
    []
  end

end
