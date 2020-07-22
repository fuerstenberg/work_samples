class RouteSerializer < MapItemSerializer

  attributes :name, :distance, :waypoints

  def url
    "/motorradtouren/#{object.slug}"
  end

end
