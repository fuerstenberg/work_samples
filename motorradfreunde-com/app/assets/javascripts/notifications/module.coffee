#= require_tree .

@Motorradfreunde.module 'Application.Notifications', (Notifications, App, Backbone, Marionette, $, _) ->

  Notifications.addInitializer ->
    if App.currentUser.loggedIn()
      notifications = new App.Application.Collection.Notifications
      @listenTo notifications, 'sync', ->
        $('.js--notifications-menu span').remove()
      $('.js--notifications-menu').click ->
        notifications.fetch()
