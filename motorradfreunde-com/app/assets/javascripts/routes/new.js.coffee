@Motorradfreunde.module 'Application.Route', (Route, App, Backbone, Marionette, $, _) ->

  class Route.New extends Motorradfreunde.Application.Map.Layout

    ui:
      search:            ".fullscreen-map__search"
      searchField:       "input#search"
      headline:          ".title h1"
      nextButton:        ".nextButton"
      routeForm:         ".fullscreen-map__route"
      routeInfo:         ".route_info"
      saveButton:        ".btn-save"
      nameField:         "input#name"
      descriptionField:  "textarea#description"
      alertBox:          ".alert.alert-danger"

    events:
      "keyup input#search":         "handleSearch"
      "keyup input#name":           "updateModelAttributes"
      "keyup textarea#description": "updateModelAttributes"
      "click .nextButton":          "handleNextButtonClick"
      "click .btn-close":           "handleFormCloseClick"
      "click .btn-save":            "handleFormSaveClick"


    initialize: ->
      super
      @model = new App.Application.Model.Route()
      @bindUIElements()
      @handleEvents()


    handleEvents: =>
      @handleInvalidModel()
      @handleRouteSegmentsChanged()
      @handleGeocoderSearchResult()
      @handleMapLoaded()


    handleMapLoaded: ->
      App.vent.on 'map.loaded', =>
        @map.setOptions
          disableDoubleClickZoom: true
          scrollwheel: false
          draggableCursor: "crosshair"
          zoom: 10
        @model.setMap @map
        @model.enableEditMode()


    handleInvalidModel: =>
      @model.bind 'invalid', =>
        console.log 'invalid'


    handleRouteSegmentsChanged: =>
      App.vent.on 'route.segments.changed', =>
        if @model.distance() and @model.distance() > 0
          @ui.headline.text "#{Math.round(@model.distance() / 100) / 10} km"
        if @model.routeSegments.length > 1
          @ui.nextButton.fadeIn()
        else
          @ui.nextButton.fadeOut()


    handleNextButtonClick: (event) =>
      @ui.routeForm.fadeIn()
      @ui.search.fadeOut()
      @ui.routeInfo.fadeOut()
      event.preventDefault()



    handleFormCloseClick: =>
      @ui.routeForm.fadeOut()
      @ui.search.fadeIn()
      @ui.routeInfo.fadeIn()


    handleFormSaveClick: =>
      @ui.saveButton.fadeOut()
      @model.save {},
        success: (model) =>
          window.location = "/motorradtouren/#{model.get('slug')}"
        error: => @ui.saveButton.fadeIn()


    handleSearch: => @model.search(@ui.searchField.val())


    handleGeocoderSearchResult: =>
      App.vent.on 'geocoder.search.result', (location) =>
        @map.setCenter location


    updateModelAttributes: =>
      @model.set
        name:         @ui.nameField.val()
        description:  @ui.descriptionField.val()
      if @model.isValid()
        @ui.alertBox.text('').fadeOut()
        @ui.saveButton.fadeIn()
      else
        @ui.saveButton.fadeOut()
        @ui.alertBox.text(@model.validationError).fadeIn()


    save: =>
      if @model.valid()
        @model.save()
      else
        @ui.nameField.removeClass('error').addClass('error')
        @ui.descriptionField.removeClass('error').addClass('error')


    hideForm: =>
      @ui.closeForm.unbind 'click'
      @ui.routeForm.hide()
      @ui.search.fadeIn()
      @ui.routeInfo.fadeIn()
