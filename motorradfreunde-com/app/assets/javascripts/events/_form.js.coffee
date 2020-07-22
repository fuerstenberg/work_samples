@Motorradfreunde.module 'Application.Events', (Events, App, Backbone, Marionette, $, _) ->

  class Events.FormView extends Marionette.Layout

    ui:
      hide_time:        "#event_hide_time"
      start_at_hour:    "#event_start_at_4i"
      start_at_minute:  "#event_start_at_5i"
      end_at_hour:      "#event_end_at_4i"
      end_at_minute:    "#event_end_at_5i"


    events:
      "change .event_hide_time": "handleHideTimeChange"


    initialize: ->
      @bindUIElements()


    handleHideTimeChange: (event) ->
      event.preventDefault()

      if @ui.hide_time[0].checked
        @ui.start_at_hour.attr   "disabled", true
        @ui.start_at_minute.attr "disabled", true
        @ui.end_at_hour.attr     "disabled", true
        @ui.end_at_minute.attr   "disabled", true
      else
        @ui.start_at_hour.removeAttr   "disabled"
        @ui.start_at_minute.removeAttr "disabled"
        @ui.end_at_hour.removeAttr     "disabled"
        @ui.end_at_minute.removeAttr   "disabled"
