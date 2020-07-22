@Motorradfreunde.module 'Application.Pois', (Pois, App, Backbone, Marionette, $, _) ->

  class Pois.Controller extends Marionette.Controller

    form: (id = null) ->
      new Pois.FormView(el: 'form.new_poi')  if $('form.new_poi' ).length > 0
      new Pois.FormView(el: 'form.edit_poi') if $('form.edit_poi').length > 0
