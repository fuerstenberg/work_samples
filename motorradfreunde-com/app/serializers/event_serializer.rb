class EventSerializer < MapItemSerializer

  attributes :title, :start_at, :end_at

  def url
    "/motorradtreffen/#{object.slug}"
  end

end
