class OldRoute
  include Mongoid::Document

  store_in collection: 'routes'

  embeds_many :waypoints, cascade_callbacks: true

  field :legacy_waypoints, type: String

  def convert_waypoints
    PublicActivity.without_tracking do
      return if self.waypoints.size > 20
      puts "Converting route: #{self.id}"
      return unless self.legacy_waypoints.is_a?(String)
      points = YAML.parse(self.legacy_waypoints).to_ruby
      points.flatten(99).each do |point|
        next unless point.is_a?(Hash)
        # puts "latitude: #{point["ib"]}, longitude: #{point["ib"]}, elevation: #{point["el"]}"
        self.waypoints.build latitude: point["ib"].to_f, longitude: point["jb"].to_f, elevation: point["el"].to_i
      end
      save
    end
  end
end

class RouteWaypointMigrateService
  def initialize
    # OldRoute.no_timeout.all.each do |route|
    #   route.convert_waypoints
    # end

    Route.no_timeout.all.each do |route|
      route.waypoints.each do |waypoint|
        route.waypoints = route.waypoints.where(latitude: waypoint.latitude, longitude: waypoint.longitude).all.each do |point|
          point.destroy if point.id != waypoint.id
        end
      end
    end
  end
end
