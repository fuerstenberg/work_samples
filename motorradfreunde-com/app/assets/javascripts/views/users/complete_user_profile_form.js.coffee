@Motorradfreunde.module 'Application.View', (View, App, Backbone, Marionette, $, _) ->

  class View.CompleteUserProfileForm extends Backbone.View

    el: '#main_hint'
    # template: JST['templates/users/complete_user_profile_form']

    events:
      "change .backseat_radio": "handleBackseat"


    initialize: ->
      @model = MyApp.currentUser
      if MyApp.currentUser and !MyApp.currentUser.hasBackseatStatus()
        @render()


    handleBackseat: (event) =>
      @model.save backseat_list: [event.target.value]


    render: =>
      @$el.hide().html(@template(@model)).delay(0).slideDown()
