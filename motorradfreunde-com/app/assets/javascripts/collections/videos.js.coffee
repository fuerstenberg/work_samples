@Motorradfreunde.module 'Application.Collection', (Collection, App, Backbone, Marionette, $, _) ->

  class Collection.Video extends Backbone.Collection

    model: App.Application.Model.Video

    url: '/api/videos'

    initialize: ->
      # App.vent.on 'map.loaded map.center.changed map.bounds.changed', (mapView) =>
      #   @map = mapView.map
      #   @getCollection = mapView.mapOptions.get_collection
      #   if @getCollection and @map.getZoom() >= @loadAtZoomLevel
      #     @fetch
      #       data:
      #         filter: @getCollection
      #         bounds: @map.getBounds().toUrlValue()
      #       remove: false
      # console.log "set window collection for debugging"


    # model: (attributes, options) =>
    #   console.log "model in collection"
    #   switch attributes.object_type
    #     when "CurrentUser"
    #       new App.Application.Model.CurrentUser(attributes, options)
    #     when "Event"
    #       new App.Application.Model.Event(attributes, options)
    #     when "Poi"
    #       new App.Application.Model.Poi(attributes, options)
    #     when "Route"
    #       new App.Application.Model.Route(attributes, options)
    #     when "User"
    #       new App.Application.Model.User(attributes, options)
    #     else
    #       new App.Application.Model.MapItem(attributes, options)


    # # add only items which are new and not included in the collection,
    # # this is very important, also the option in @fetch (near line 16) which never removes items
    # parse: (response) =>
    #   result = []
    #   for item in response
    #     result.push item if !@get(item.id)
    #   result
