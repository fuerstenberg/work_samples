#= require ./_ride_request
@Motorradfreunde.module 'Application.RideRequest', (RideRequest, App, Backbone, Marionette, $, _) ->

  class RideRequest.Panel extends Marionette.CompositeView

    # template: JST['templates/ride_requests/panel']

    itemViewContainer: "ul#itemViewContainer"

    ui:
      "drivingStyleSelect": ".ride-request-form #driving_style"
      "dayButton":          ".ride-request-form .day-btn"
      "dayButtonGroup":     ".ride-request-form .form-group-btn-group"

    events:
      "click .ride-request-form .day-btn:not(.disabled)": "handleDayButtonClick"
      "change .ride-request-form #driving_style":         "handleDrivingStyleSelect"
      "click #ride-request-panel-dropdown-toggle":        "handleDropDownToggle"

    modelEvents:
      "change:start_at":      "modelChanged"
      "change:driving_style": "modelChanged"
      "change":               "updateDayButtons"
      "sync":                 "modelSaved"

    collectionEvents:
      "change": "updateDayButtons"


    initialize: ->
      @itemView = RideRequest.RideRequest
      @bindUIElements()
      @handleDropDownToggle() if 2 < (new Date()).getMonth() and (new Date()).getMonth() < 11 and (Math.random() * 20) > 9 and @collection.length == 0


    handleDropDownToggle: (event = null) ->
      event.preventDefault() if event
      if @$el.hasClass('open')
        @model.clear()
        @$el.removeClass 'open'
      else
        @$el.addClass('open')


    handleDrivingStyleSelect: (event) ->
      event.preventDefault()
      if @ui.drivingStyleSelect.val().length > 0
        @model.set 'driving_style', @ui.drivingStyleSelect.val()
      else
        @model.clear()


    handleDayButtonClick: (event) ->
      event.preventDefault()
      @model.set 'start_at', $(event.target).data('startAt')
      $(event.target).attr('disabled', 'disabled')


    modelChanged: ->
      if @model.get('start_at') and @model.get('driving_style')
        @model.save() if @model.isNew()
      else if @model.get('driving_style')
        @ui.dayButtonGroup.removeClass 'hidden'
      else
        @ui.drivingStyleSelect.val null
        @ui.dayButtonGroup.removeClass('hidden').addClass('hidden')


    modelSaved: ->
      @collection.add @model.clone()
      @render()
      @model.clear()


    updateDayButtons: ->
      for model in @collection.models
        $("button.day-btn[data-start-at=\"#{model.get('start_at').split("T")[0]}\"]").attr('disabled', 'disabled')
