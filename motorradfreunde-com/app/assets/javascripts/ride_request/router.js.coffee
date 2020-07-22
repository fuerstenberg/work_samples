@Motorradfreunde.module 'Application.RideRequest', (RideRequest, App, Backbone, Marionette, $, _) ->

  class RideRequest.Router extends Marionette.AppRouter

    controller: new RideRequest.Controller()
