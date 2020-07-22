#= require ./map_item

@Motorradfreunde.module 'Application.Model', (Model, App, Backbone, Marionette, $, _) ->

  class Model.RideRequest extends Model.MapItem

    url: '/api/ride_requests'

    wrapParameters: "ride_request"
