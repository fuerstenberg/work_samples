class ActivityBaseService

  delegate :enabled?, to: :class

  mattr_accessor :enabled do
    !Rails.env.test?
  end

  def initialize(object:, on:, key: nil)
    @key = key
    @object = object
    @on = on
  end

  def self.enabled?
    enabled
  end

  def self.process(object:, on:, key: nil)
    klass = [object.class.to_s, 'ActivityService'].join('::').constantize
    klass.new(object: object, on: on, key: key).process
  rescue LoadError
    puts [object.class.to_s, 'ActivityService'].join('::')
  end

  def process
    if enabled? and (on_create? or on_update?)
      activity = PublicActivity::Activity.find_or_initialize_by(key: key, owner: owner, trackable: trackable) do |activity|
        activity.changed_fields = changed_fields
        activity.coordinates    = coordinates
        activity.parent         = parent
        activity.user_ids       = user_ids
      end
      activity.save
    elsif enabled? and on_destroy?
    end
  end

  private

  def changed_fields
    {}
  end

  def coordinates
    @object.try(:address).try(:coordinates) || @object.try(:user).try(:address).try(:coordinates)
  end

  def key
    @key or [ @object.class.to_s.underscore, @on ].map(&:to_s).join '.'
  end

  def on_create?
    @on.to_s == 'create'
  end

  def on_destroy?
    @on.to_s == 'destroy'
  end

  def on_update?
    @on.to_s == 'update'
  end

  def owner
    @object.try :user
  end

  def parent
    @object
  end

  def trackable
    @object
  end

  def users
    [
      @object.try(:user),
      @object.try(:editor),
      @object.try(:creator),
      owner.try(:friends)
    ].flatten(99).compact.uniq
  end

  def user_ids
    users.flatten(99).compact.uniq.map &:id
  end

end
