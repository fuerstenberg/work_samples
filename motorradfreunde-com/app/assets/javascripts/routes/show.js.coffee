@Motorradfreunde.module 'Application.Route', (Route, App, Backbone, Marionette, $, _) ->

  class Route.Show extends Motorradfreunde.Application.Map.Layout

    initialize: ->
      super
      App.vent.on 'map.loaded', =>
        if gon.route
          @model = new App.Application.Model.Route gon.route
          @model.load()
          @model.setMap @map
          @model.centerMap()
          @model.draw()

# class App.RoutesShow extends App.MapView

#   handleEvents: =>
#     @$el.bind 'map:loaded', =>
#       new App.Route.find params['id'], (attributes) =>
#         @route = new App.Route attributes, @map
#         @route.load()

#       $(@route).bind 'directions_changed', @handleDirectionsChanged
