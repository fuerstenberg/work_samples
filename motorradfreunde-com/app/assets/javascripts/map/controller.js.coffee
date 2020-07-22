@Motorradfreunde.module 'Application.Map', (Map, App, Backbone, Marionette, $, _) ->

  class Map.Controller extends Marionette.Controller

    index: ->
      if $('form.new_poi' ).length > 0
        @form()
      else
        new Map.CollectionView el: '.map'


    show: (id) ->
      if $('form.edit_poi').length > 0
        @form(id)
      else
        new Map.ItemView el: '.map'


    form: (id = null) ->
      if id
        new Map.FormView(el: 'form.edit_poi')   if $('form.edit_poi').length > 0
        new Map.FormView(el: 'form.edit_event') if $('form.edit_event').length > 0
      else
        new Map.FormView(el: 'form.new_poi')   if $('form.new_poi').length > 0
        new Map.FormView(el: 'form.new_event') if $('form.new_event').length > 0
