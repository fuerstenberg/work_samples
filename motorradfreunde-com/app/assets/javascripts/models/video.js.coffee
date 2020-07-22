#= require ./active_record

@Motorradfreunde.module 'Application.Model', (Model, App, Backbone, Marionette, $, _) ->

  class Model.Video extends Model.ActiveRecord

    urlRoot: '/api/videos'

    # initialize: ->
    #   App.vent.on 'map.bounds.changed', (mapView) =>
    #     @mapOptions = mapView.mapOptions
    #     @renderMarker(mapView.map)
