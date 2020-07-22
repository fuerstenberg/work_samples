class PoiSerializer < MapItemSerializer

  attributes :name

  def url
    "/orte/#{object.slug}"
  end

end
