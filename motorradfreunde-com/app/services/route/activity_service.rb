class Route::ActivityService < ActivityBaseService

  private

  def users
    super + User.near_by(@object, 80).to_a
  end

end
