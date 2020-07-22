#= require ./_layout

@Motorradfreunde.module 'Application.Map', (Map, App, Backbone, Marionette, $, _) ->

  class Map.CollectionView extends Map.Layout

    initialize: ->
      super
