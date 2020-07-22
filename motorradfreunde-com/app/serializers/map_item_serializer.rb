class MapItemSerializer < ActiveModel::Serializer

  attributes :id, :latitude, :longitude, :object_type, :url

  def id
    object.id.to_s
  end

  def latitude
    object.to_coordinates[0]
  end

  def longitude
    object.to_coordinates[1]
  end

  def object_type
    object.class.to_s
  end

  def url
    polymorphic_url object, only_path: true rescue nil
  end

end
