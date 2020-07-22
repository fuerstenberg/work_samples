#= require_tree .

@Motorradfreunde.module 'Application.Route', (Route, App, Backbone, Marionette, $, _) ->

  Route.addInitializer ->
    @router = new Route.Router()
