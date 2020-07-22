json.array!(@screens) do |screen|
  json.extract! screen, :id, :name
  json.url screen_url(screen, format: :json)
end
