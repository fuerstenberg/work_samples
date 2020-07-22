class Image::ActivityService < ActivityBaseService

  private

  def parent
    @object.imageable
  end

  def users
    if @object&.imageable.is_a? User
      super + [ @object&.imageable ]
    else
      super + [ @object.try(:imageable).try(:user), @object.try(:imageable).try(:poster) ].compact.uniq
    end
  end

end
