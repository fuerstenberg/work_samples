#= require ./user

@Motorradfreunde.module 'Application.Model', (Model, App, Backbone, Marionette, $, _) ->

  Model.addInitializer -> Motorradfreunde.currentUser = new Model.CurrentUser(gon.currentUser)


  class Model.CurrentUser extends Model.User

    url: '/api/sessions'

    visibleAtZoomLevel: 1

    markerIcon: => @_markerIcon ||= new google.maps.MarkerImage('/assets/markers/marker_blue.png')


    initialize: ->
      super
      @set window.gon.currentUser
      @bind 'change', @handleChange


    handleChange: =>
      @save() if @changed.latitude or @changed.longitude


    loggedIn: ->
      !!@id


    markerOptions: ->
      options = super
      options.icon = @markerIcon()
      options.draggable = true
      options.animation = google.maps.Animation.DROP
      options


    renderMarker: (map) =>
      super
      if @inBounds() and @mapOptions.display_current_user
        @showMarker()
      else
        @hideMarker()


    updateMarker: =>
      if @map and @marker
        @latLng = new google.maps.LatLng @get('latitude'), @get('longitude')
        @marker.setPosition @latLng
