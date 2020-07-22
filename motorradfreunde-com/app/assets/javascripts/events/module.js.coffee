#= require_tree .

@Motorradfreunde.module 'Application.Events', (Events, App, Backbone, Marionette, $, _) ->

  Events.addInitializer ->
    if !!$('form.new_event').length? or $('form.edit_event').length?
      new Events.FormView el: 'form'
