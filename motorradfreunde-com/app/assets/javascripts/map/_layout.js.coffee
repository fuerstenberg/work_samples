@Motorradfreunde.module 'Application.Map', (Map, App, Backbone, Marionette, $, _) ->

  class Map.Layout extends Marionette.Layout

    defaultMapOptions:
      zoom:                   9
      center:                 new google.maps.LatLng(52,13)
      mapTypeId:              google.maps.MapTypeId.ROADMAP
      minZoom:                3
      scrollwheel:            false
      navigationControl:      false
      scaleControl:           true
      draggable:              true
      mapTypeControl:         true
      mapTypeControlOptions:
        style: google.maps.MapTypeControlStyle.DROPDOWN_MENU


    modelEvents:
      "change": "renderMapItem"

    collectionEvents:
      "add": "renderMapItem"


    initialize: ->
      @mapOptions = gon.map_options
      @collection = new App.Application.Collection.MapItem()

      # if @mapOptions.display_current_user and gon.currentUser
      if gon.currentUser
        @defaultMapOptions.center = new google.maps.LatLng(gon.currentUser.latitude, gon.currentUser.longitude)

      if @mapOptions.highlight_item
        @defaultMapOptions.center = new google.maps.LatLng(@mapOptions.highlight_item.latitude, @mapOptions.highlight_item.longitude)
        @collection.on 'change', =>
          App.vent.trigger 'map.highlight.item', @mapOptions.highlight_item.id
        @collection.add @mapOptions.highlight_item
        App.vent.trigger 'map.highlight.item', @mapOptions.highlight_item.id

      @initializeMap()


    initializeMap: ->
      mapCanvas = $('.map__canvas', @el)
      if mapCanvas.length > 0
        @map_loaded = false
        @map = new google.maps.Map mapCanvas[0], @defaultMapOptions
        @handleMapEvents()


    handleMapEvents: =>
      google.maps.event.addListener @map, 'idle',           @handleMapIdle
      google.maps.event.addListener @map, 'center_changed', @handleMapCenterChanged
      google.maps.event.addListener @map, 'bounds_changed', @handleMapBoundsChanged


    handleMapIdle: =>
      if @map_loaded
        App.vent.trigger 'map.idle', @
      else
        @map_loaded = true
        App.vent.trigger 'map.loaded', @
        @showGrip()


    handleMapBoundsChanged: =>
      window.clearTimeout @boundsTimeout if @boundsTimeout
      @boundsTimeout = setTimeout =>
        App.vent.trigger 'map.bounds.changed', @
        App.vent.trigger 'map.changed', @
      , 500


    handleMapCenterChanged: =>
      window.clearTimeout @centerTimeout if @centerTimeout
      @centerTimeout = setTimeout =>
        App.vent.trigger 'map.center.changed', @
        App.vent.trigger 'map.changed', @
      , 500


    renderMapItem: (model) ->
      model.renderMarker(@map)


    showGrip: ->
      grip = $('.map_grip', @$el)
      parentElement = grip.parent()
      min_height = parseInt(parentElement.css('min-height'))
      grip.show().delay(1000).animate(bottom: '-25px')
      grip.draggable
        axis: "y"
        scroll: false
        start: (event, data) =>
          parentElement.height data.position.top
        drag: (event, data) =>
          parentElement.height data.position.top
        stop: (event, data) =>
          parentElement.height data.position.top
          google.maps.event.trigger(@map, 'resize')
          grip.show().animate(bottom: '-20px', top: parentElement.height())
