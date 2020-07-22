class Waypoint

  include Mongoid::Document

  embedded_in :route

  # "ib"=>"47.59243", "jb"=>"8.13002", "el"=>"325"
  field :latitude,  type: Float
  field :longitude, type: Float
  field :elevation, type: Integer

  alias ib= latitude=
  alias jb= longitude=
  alias el= elevation=

end
