#= require ./controller

@Motorradfreunde.module 'Application', (Application, App, Backbone, Marionette, $, _) ->

  class Application.Router extends Marionette.AppRouter

    controller: new Application.Controller()
