class Poi::ActivityService < ActivityBaseService

  private

  def owner
    @object&.editor || @object&.owner || @object&.creator || super
  end

  def users
    super + User.near_by(@object, 80).to_a
  end

end
