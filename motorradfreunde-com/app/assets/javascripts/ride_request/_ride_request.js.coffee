@Motorradfreunde.module 'Application.RideRequest', (RideRequest, App, Backbone, Marionette, $, _) ->

  class RideRequest.RideRequest extends Marionette.ItemView

    tagName:   "li"
    className: "ride_request"
    # template:  JST['templates/ride_requests/ride_request']
