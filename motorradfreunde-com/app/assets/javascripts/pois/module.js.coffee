#= require_tree .

@Motorradfreunde.module 'Application.Pois', (Pois, App, Backbone, Marionette, $, _) ->

  Pois.addInitializer ->
    if $('form.new_poi').length > 0 or $('form.edit_poi').length > 0
      poisController = new Pois.Controller()
      poisController.form()
