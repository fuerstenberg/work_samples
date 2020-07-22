class MapItem

  def self.in_bounds(bounds, current_user)
    collection  = []
    if bounds.present?
      collection += Event.in_bounds bounds
      collection += User.in_bounds  bounds
      collection += Poi.in_bounds   bounds
    end
    if current_user
      Struct.const_defined?("CurrentUser") || Struct.new("CurrentUser", :id, :name, :latitude, :longitude, :object_type, :to_s)
      current_user_struct = Struct::CurrentUser.new current_user.id, current_user.name, current_user.latitude, current_user.longitude, "CurrentUser", current_user.name
      collection += [current_user_struct]
      collection -= [current_user]
    end
    collection.map{|item| item.to_json(only: [:latitude, :longitude, :id, :name, :title, :start_at, :end_at], methods: [:to_s, :object_type])}
  end

end
