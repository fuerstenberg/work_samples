@Motorradfreunde.module 'Application', (Application, App, Backbone, Marionette, $, _) ->

  class Application.Controller extends Marionette.Controller

    initialize: ->
      @layout = new Application.Layout()
