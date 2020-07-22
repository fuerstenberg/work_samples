class User::ActivityService < ActivityBaseService

  private

  def changed_fields
    @object.previous_changes.select{ |k, v| trackable_attributes.map(&:to_s).include?(k) }
  end

  def owner
    @object
  end

  def trackable_attributes
    [
      :name,
      :date_of_birth,
      :description,
      :distance_per_year,
      :distance_total,
      :driving_description,
      :favorite_clothing,
      :favorite_drive_type,
      :favorite_driving_style,
      :favorite_engine_amount_of_cylinders,
      :favorite_vendor,
      :favourite_areas,
      :favourite_experience,
      :gender,
      :has_own_motorcycle,
      :interested_in_gender,
      :licence_date,
      :status_as_biker,
      :status_for_backseat,
      :status_for_relationship,
      :status_of_social_behavior,
    ]
  end

  def users
    super + User.near_by(@object, 20).to_a
  end

end
