#= require ./_layout

@Motorradfreunde.module 'Application.Map', (Map, App, Backbone, Marionette, $, _) ->

  class Map.ItemView extends Map.Layout

    initialize: ->
      super
      # @search()
