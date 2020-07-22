@Motorradfreunde.module 'Application.Collection', (Collection, App, Backbone, Marionette, $, _) ->

  class Collection.RideRequest extends Backbone.Collection

    model: App.Application.Model.RideRequest

    url: '/api/ride_requests'
