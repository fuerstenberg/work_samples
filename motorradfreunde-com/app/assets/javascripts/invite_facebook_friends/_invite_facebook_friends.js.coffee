@Motorradfreunde.module 'Application.InviteFacebookFriends', (InviteFacebookFriends, App, Backbone, Marionette, $, _) ->

  class InviteFacebookFriends.View extends Marionette.View

    el: ".send_facebook_message"

    events:
      "click": "handleClick"


    initialize: ->
      if gon.currentUser and gon.currentUser.facebooker
        @$el.show()
        @$el.fadeIn()
      else
        @$el.hide()


    handleClick: (event) =>
      event.preventDefault()
      FB.ui
        method: 'apprequests'
        message: 'Ich bin bei Motorradfreunde.com - komm doch auch rein...'
