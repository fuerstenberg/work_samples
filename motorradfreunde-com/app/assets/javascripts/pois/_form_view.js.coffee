#= require ./_layout

@Motorradfreunde.module 'Application.Pois', (Pois, App, Backbone, Marionette, $, _) ->

  class Pois.FormView extends Pois.Layout

    events:
      'change input#poi_is_bike_builder':   'typeChanged'
      'change input#poi_is_dealer':         'typeChanged'
      'change input#poi_is_hotel':          'typeChanged'
      'change input#poi_is_magazin':        'typeChanged'
      'change input#poi_is_mountain_pass':  'typeChanged'
      'change input#poi_is_rental_company': 'typeChanged'
      'change input#poi_is_shop':           'typeChanged'
      'change input#poi_is_tour_operator':  'typeChanged'
      'change input#poi_is_vendor':         'typeChanged'
      'change input#poi_is_workshop':       'typeChanged'


    initialize: ->
      @bindUIElements()
      super


    typeChanged: (event) ->
      fields = document.getElementsByClassName event.target.dataset.fields
      if event.target.checked
        for field in fields
          field.classList.remove('hidden-xs-up')
      else
        for field in fields
          field.classList.add('hidden-xs-up')
