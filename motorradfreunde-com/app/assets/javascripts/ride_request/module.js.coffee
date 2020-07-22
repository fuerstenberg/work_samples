#= require_tree .

@Motorradfreunde.module 'Application.RideRequest', (RideRequest, App, Backbone, Marionette, $, _) ->

  RideRequest.addInitializer ->
    @router = new RideRequest.Router()
