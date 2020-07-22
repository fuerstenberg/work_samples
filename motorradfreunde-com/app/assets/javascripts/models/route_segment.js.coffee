#= require ./map_item

@Motorradfreunde.module 'Application.Model', (Model, App, Backbone, Marionette, $, _) ->

  class Model.RouteSegment extends Model.ActiveRecord

    markerGreen: new google.maps.MarkerImage('/assets/markers/marker_green.png')
    markerBlue:  new google.maps.MarkerImage('/assets/markers/marker_blue.png')
    markerRed:   new google.maps.MarkerImage('/assets/markers/marker_red.png')

    # constructor: (@route, @origin, @options) ->
    initialize: (@route, @origin, @options) ->
      @path = []
      @distance = 0
      @route.routeSegments.push @

      if @options.editable
        Model.RouteSegment.service  = new google.maps.DirectionsService() unless Model.RouteSegment.service
        Model.RouteSegment.elevator = new google.maps.ElevationService()  unless Model.RouteSegment.elevator

        if @prev()
          @prev().getDirections()
        else
          @renderMarker()


    getDirections: ->
      if @next()
        serviceOptions =
          origin:       @origin
          destination:  @next().origin
          travelMode:   google.maps.DirectionsTravelMode.DRIVING
        Model.RouteSegment.service.route serviceOptions, @saveDirectionsResult
      else
        @distance = 0
        @path = []
        @renderMarker()
        @route.draw()


    saveDirectionsResult: (result, status) =>
      if status == google.maps.DirectionsStatus.OK
        @path = result.routes[0].overview_path
        @distance = result.routes[0].legs[0].distance.value
        @origin = @path[0]
        @next().origin = @path[@path.length - 1]
        @renderMarker()
        @next().renderMarker()
        @route.draw()
        @getElevation()

        App.vent.trigger 'route.segments.changed', @
        @route.trigger 'route.segments.changed', @


    renderMarker: () ->
      @removeMarker()
      @marker = new google.maps.Marker
        position: @origin,
        map:      @route.map
        icon:     @markerIcon()
        draggable: true
      google.maps.event.addListener @marker, "click", @remove
      google.maps.event.addListener @marker, "dragend", @markerMoved


    markerIcon: ->
      if @isFirst()
        @markerGreen
      else if @isLast()
        @markerRed
      else
        @markerBlue


    markerMoved: (event) =>
      @origin = event.latLng
      @getDirections()
      @prev().getDirections() if @prev()


    removeMarker: ->
      @marker.setMap null if @marker


    remove: =>
      @removeMarker()
      prev = @prev()
      @route.routeSegments.splice @route.routeSegments.indexOf(@), 1
      if prev
        prev.path = []
        prev.getDirections()
      else
        @next().renderMarker() if @next()
        @route.draw()
      App.vent.trigger 'route.segments.changed', @
      @route.trigger 'route.segments.changed', @


    isFirst: ->
      @route.routeSegments.indexOf(@) == 0


    isLast: ->
      @route.routeSegments.indexOf(@) == (@route.routeSegments.length - 1)


    prev: ->
      @route.routeSegments[@route.routeSegments.indexOf(@) - 1]


    next: ->
      @route.routeSegments[@route.routeSegments.indexOf(@) + 1]


    getElevation: =>
      Model.RouteSegment.elevator.getElevationForLocations {locations: @path}, (results, status) =>
        if (status == google.maps.ElevationStatus.OK)
          @path[index].elevation = result.elevation for result, index in results

