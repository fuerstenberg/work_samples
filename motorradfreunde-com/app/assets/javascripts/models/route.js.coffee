#= require ./map_item

@Motorradfreunde.module 'Application.Model', (Model, App, Backbone, Marionette, $, _) ->

  class Model.Route extends Model.MapItem

    url: '/motorradtouren'

    wrapParameters: "route"

    initialize: ->
      super
      @routeSegments = []


    load: =>
      segment = new Model.RouteSegment(@, null, { editable: false })
      for waypoint in @attributes.waypoints
        point = new google.maps.LatLng(waypoint.latitude, waypoint.longitude)
        point.elevation = waypoint.elevation
        segment.path.push point
      @draw()


    centerMap: ->
      latlngbounds = new google.maps.LatLngBounds()
      for n in @route()
        latlngbounds.extend(n)
      @map.setCenter latlngbounds.getCenter()
      @map.fitBounds latlngbounds


    enableEditMode: =>
      @geocoder ||= new google.maps.Geocoder()
      google.maps.event.addListener @map, "click", @handleMapClick


    handleMapClick: (event) =>
      new Model.RouteSegment(@, event.latLng, {editable: true})


    setMap: (map) =>
      @map = map


    draw: ->
      unless @poly
        @poly = new google.maps.Polyline
          map:            @map
          strokeColor:    "#0000FF"
          strokeOpacity:  0.7
          strokeWeight:   4
      @poly.setPath @route()
      @poly.setMap @map
      $(@).trigger 'change'


    route: ->
      route = []
      for segment in @routeSegments
        route = route.concat(segment.path)
      route


    routeAsHash: ->
      (for waypoint in @route()
        {
          ib: (waypoint.lat().toFixed(5) if waypoint.lat())
          jb: (waypoint.lng().toFixed(5) if waypoint.lng())
          el: (waypoint.elevation.toFixed(0) if waypoint.elevation)
        }
      )


    distance: ->
      distance = 0
      distance = distance + segment.distance for segment in @routeSegments
      distance


    search: (address) ->
      @geocoder.geocode { 'address': address}, (results, status) =>
        if status == google.maps.GeocoderStatus.OK
          App.vent.trigger 'geocoder.search.result', results[0].geometry.location


    generateStatic: ->
      google.maps.geometry.encoding.encodePath (segment.origin for segment in @routeSegments[0..19])


    handleRouteSegmentsChanged: (segment) =>
      @attributes.distance        = @distance()
      @attributes.waypoints       = @routeAsHash()
      @attributes.static_polyline = @generateStatic()
      @attributes.latitude        = @attributes.waypoints[0]["ib"]
      @attributes.longitude       = @attributes.waypoints[0]["jb"]


    toJSON: ->
      @attributes.distance        = @distance()
      @attributes.waypoints       = @routeAsHash()
      @attributes.static_polyline = @generateStatic()
      @attributes.address_attributes =
        latitude:  @attributes.waypoints[0]["ib"]
        longitude: @attributes.waypoints[0]["jb"]
      super

    validate: (attrs, options) ->
      if @routeSegments.length < 2
        return "Zu wenig Wegpunkte"
      if attrs.name.length < 5
        return "Name zu kurz"
      if attrs.description.length < 20
        return "Beschreibung zu kurz"


    window: =>
      """
        <a href="#{@get('url')}">#{@get('name')}</a>
        <div class="distance">Länge: ca. #{Math.round(@get('distance') / 1000)} km</div>
      """
