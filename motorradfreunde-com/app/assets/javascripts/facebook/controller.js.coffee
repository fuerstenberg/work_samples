@Motorradfreunde.module 'Application.Facebook', (Facebook, App, Backbone, Marionette, $, _) ->

  class Facebook.Controller extends Marionette.Controller

    initialize: ->
      @handleEvents()
      @intitializeFacebook()


    intitializeFacebook: ->
      window.fbAsyncInit = Controller.fbAsyncInit
      $('body').append('<div id="fb-root"></div>')
      $.ajax
        url: "#{window.location.protocol}//connect.facebook.net/de_DE/all.js"
        dataType: 'script'
        cache: true


    handleEvents: =>
      App.vent.on 'facebook:initialized', =>
        FB.getLoginStatus (response) =>
          if response and response.status == "connected" and response.authResponse
            App.vent.trigger 'facebook:connected'


    # authorize: (callback) =>
    #   if FB.getAuthResponse()
    #     App.vent.trigger 'facebook:authorized', this
    #     callback()
    #   else
    #     FB.login (response) =>
    #       if response.status == 'connected'
    #         callback()
    #     , {scope: 'publish_stream,publish_actions,email'}


    # getFriends: (callback) =>
    #   @authorize =>
    #     FB.api '/me?fields=friends', (response) =>
    #       @friends = response.friends.data
    #       @friends.sort (a,b) ->
    #         if a.name < b.name
    #           return -1
    #         if a.name > b.name
    #           return 1
    #         return 0
    #       callback(@friends)


    @fbAsyncInit: ->
      FB.init
        appId:   window.gon.facebookApplicationId
        cookie:  true
        xfbml:   true
        version: 'v2.9'
      App.vent.trigger 'facebook:initialized'
