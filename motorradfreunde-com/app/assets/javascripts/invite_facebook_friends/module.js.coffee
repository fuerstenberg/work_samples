#= require_tree .

@Motorradfreunde.module 'Application.InviteFacebookFriends', (InviteFacebookFriends, App, Backbone, Marionette, $, _) ->

  InviteFacebookFriends.addInitializer ->
    App.vent.on 'facebook:connected', =>
      @view = new InviteFacebookFriends.View()
