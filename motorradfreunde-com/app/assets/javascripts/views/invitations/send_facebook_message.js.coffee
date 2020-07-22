@Motorradfreunde.module 'Application.View', (View, App, Backbone, Marionette, $, _) ->

  class View.SendFacebookMessage extends Backbone.View

    el: ".send_facebook_message"

    initialize: ->
      if gon.currentUser.facebooker
        @$el.fadeIn()
        @model = MyApp.currentUser
        @$el.on 'click', @handleInviteFriends
      else
        @$el.hide()


    handleInviteFriends: (event) =>
      event.preventDefault()
      element = $(event.target)
      App.facebook.sendMessage(element.data('title'), element.data('description'))

      # does only work on live systems,
      # because Facebook is looking for a page title,
      # but in dev-mode you are behind a firewall
      FB.ui
        app_id: App.facebookAppId
        method: 'send'
        link:   window.location.href
