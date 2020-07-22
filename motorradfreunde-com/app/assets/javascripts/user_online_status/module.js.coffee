#= require_tree .

@Motorradfreunde.module 'Application.UserOnlineStatus', (UserOnlineStatus, App, Backbone, Marionette, $, _) ->

  UserOnlineStatus.addInitializer ->
    for id in window.gon.onlineUserIds
      $("[data-user-id=#{id}]").addClass('is-online')
