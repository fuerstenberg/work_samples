@Motorradfreunde.module 'Application.RideRequest', (RideRequest, App, Backbone, Marionette, $, _) ->

  class RideRequest.Controller extends Marionette.Controller

    initialize: ->
      if $('.ride-request-panel' ).length > 0
        panel = new RideRequest.Panel
          el:         '#ride-request-panel'
          model:      new App.Application.Model.RideRequest()
          collection: new App.Application.Collection.RideRequest(gon.rideRequests)
        panel.collection.comparator = 'start_at'
        panel.render()
        # panel.collection.reset gon.rideRequests
