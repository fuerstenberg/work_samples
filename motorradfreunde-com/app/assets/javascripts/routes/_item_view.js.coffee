@Motorradfreunde.module 'Application.Route', (Route, App, Backbone, Marionette, $, _) ->

  class Route.ItemView extends Motorradfreunde.Application.Map.Layout

    initialize: ->
      super
      # @search()
