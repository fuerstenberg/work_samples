#= require ./_layout

@Motorradfreunde.module 'Application.Map', (Map, App, Backbone, Marionette, $, _) ->

  class Map.FormView extends Map.Layout

    ui:
      country:     ".map_country"
      postalCode:  ".map_postal_code"
      city:        ".map_city"
      route:       ".map_route"
      latitude:    ".map_latitude"
      longitude:   ".map_longitude"


    events:
      "change .map_country":     "search"
      "keyup  .map_postal_code": "search"
      "keyup  .map_city":        "search"
      "keyup  .map_route":       "search"


    initialize: ->
      @bindUIElements()
      super
      @model = @collection.highlighted()[0]
      @model.bind "change", =>
        @ui.latitude.val  @model.get('latitude')
        @ui.longitude.val @model.get('longitude')
      @model.marker.setOptions
        draggable: true
        animation: google.maps.Animation.DROP
      @search()


    search: =>
      if @map?
        query = _.compact([
          @ui.country.val(),
          @ui.postalCode.val(),
          @ui.city.val(),
          @ui.route.val()
        ]).join(' ')
        @model.geoCodeAddressToPosition query
