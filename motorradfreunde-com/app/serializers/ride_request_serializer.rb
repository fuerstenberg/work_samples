class RideRequestSerializer < ActiveModel::Serializer

  # self.root = false

  attributes :id, :start_at, :driving_style, :object_type, :url

  def object_type
    object.class.to_s
  end

  def url
    polymorphic_url object, only_path: true
  end

end
