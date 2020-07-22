class Event::ActivityService < ActivityBaseService

  private

  def users
    super + User.near_by(@object, 50).to_a
  end

end
