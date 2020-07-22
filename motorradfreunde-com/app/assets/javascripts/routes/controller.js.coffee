@Motorradfreunde.module 'Application.Route', (Route, App, Backbone, Marionette, $, _) ->

  class Route.Controller extends Marionette.Controller

    show: (id) ->
      new Route.Show el: '.map'

    new: ->
      new Route.New el: 'body.routes__new'
