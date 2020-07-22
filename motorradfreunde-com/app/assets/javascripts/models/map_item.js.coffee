#= require ./active_record

@Motorradfreunde.module 'Application.Model', (Model, App, Backbone, Marionette, $, _) ->

  class Model.MapItem extends Model.ActiveRecord

    largeMarkerIcon: => null
    smallMarkerIcon: => @_smallMarkerIcon ||= new google.maps.MarkerImage('/assets/markers/marker_red.png')
    largeHighlightMarkerIcon: => @_largeHighlightMarkerIcon ||= new google.maps.MarkerImage('/assets/markers/marker_green.png')
    smallHighlightMarkerIcon: => @_smallHighlightMarkerIcon ||= new google.maps.MarkerImage('/assets/markers/marker_green.png')

    visibleAtZoomLevel: 9
    highlight: false


    initialize: ->
      @handleBoundsChanged()
      @handleHighlightItem()
      @marker ||= new google.maps.Marker @markerOptions()
      @bind "change", @updateMarker
      @handleMarkerDragged()


    handleBoundsChanged: =>
      App.vent.on 'map.bounds.changed', (mapView) =>
        @mapOptions = mapView.mapOptions
        @renderMarker(mapView.map)


    handleHighlightItem: =>
      App.vent.on 'map.highlight.item', (id) =>
        if @id == id
          @highlight = true
        else
          @highlight = false


    handleMarkerDragged: =>
      google.maps.event.addListener @marker, "dragend", =>
        @set
          latitude:  @marker.getPosition().lat()
          longitude: @marker.getPosition().lng()


    # geoCodePositionToAddress: (callback) =>
    #   @attributes.latitude = @marker.getPosition().lat()
    #   @attributes.longitude = @marker.getPosition().lng()
    #   @geocoder ||= new google.maps.Geocoder()
    #   @geocoder.geocode {'latLng': @marker.getPosition()}, (results, status) =>
    #     if status == google.maps.GeocoderStatus.OK and results
    #       @attributes.address_components = results[0]['address_components']
    #       @attributes.address ||= {}
    #       for address_component in @attributes.address_components
    #         @attributes.address[address_component['types'][0]] = address_component['long_name']
    #       @attributes.formatted_address  = results[0].formatted_address
    #       $(this).trigger 'address:found', this
    #     callback this, status if callback


    geoCodeAddressToPosition: (address, callback) =>
      @geocoder ||= new google.maps.Geocoder()
      @geocoder.geocode {address: address}, (results, status) =>
        if status == google.maps.GeocoderStatus.OK
          @map.setZoom Math.round(results[0].address_components.length * 1.9) if @map
          @set
            latitude:  results[0].geometry.location.lat()
            longitude: results[0].geometry.location.lng()
          callback @ if callback


    getPosition: ->
      @latLng ||= new google.maps.LatLng @get('latitude'), @get('longitude')
      @latLng


    hideMarker: ->
      @marker.setMap null


    inBounds: ->
      if @map and @map.getBounds()
        @map.getBounds().contains @marker.getPosition()


    isHighlighted: ->
      !!@highlight


    markerIcon: =>
      if @highlight
        if @map and @map.getZoom() > 9
          @largeHighlightMarkerIcon()
        else if @map
          @smallHighlightMarkerIcon()
        else
          null
      else
        if @map and @map.getZoom() > 9
          @largeMarkerIcon()
        else if @map
          @smallMarkerIcon()
        else
          null


    markerOptions: ->
      icon:     @markerIcon()
      position: @getPosition()
      title:    @toString()


    toString: ->
      @get('name') or @get('title')


    renderInfoWindow: =>
      unless @infoWindow
        @infoWindow = new google.maps.InfoWindow content: @window()
        google.maps.event.addListener @marker, 'click', =>
          @infoWindow.open @map, @marker
          App.vent.trigger 'map.window.opened', @infoWindow

        App.vent.on 'map.window.opened', (infoWindow) =>
          if @infoWindow != infoWindow
            @infoWindow.close()


    renderMarker: (map) =>
      @map ||= map
      @renderInfoWindow()
      if @inBounds() and ((@map.getZoom() >= @visibleAtZoomLevel) or @isHighlighted())
        @showMarker()
      else
        @hideMarker()


    showMarker: =>
      @marker.setIcon @markerIcon()
      @marker.setMap @map unless @marker.getMap()


    updateMarker: =>
      if @map and @marker
        @latLng = new google.maps.LatLng @get('latitude'), @get('longitude')
        @marker.setPosition @latLng
        @map.setCenter @latLng if @isHighlighted()


    window: =>
      """
        <a href="#{@get('url')}">#{@get('name')}</a>
      """
