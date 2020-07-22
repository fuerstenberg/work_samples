#= require_tree .

@Motorradfreunde.module 'Application.Facebook', (Facebook, App, Backbone, Marionette, $, _) ->

  Facebook.addInitializer ->
    @controller = new Facebook.Controller()
