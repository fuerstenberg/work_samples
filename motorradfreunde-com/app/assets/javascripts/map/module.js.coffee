#= require_tree .

@Motorradfreunde.module 'Application.Map', (Map, App, Backbone, Marionette, $, _) ->

  Map.addInitializer ->
    @router = new Map.Router()
