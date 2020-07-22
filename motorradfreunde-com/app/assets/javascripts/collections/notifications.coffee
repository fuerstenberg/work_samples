@Motorradfreunde.module 'Application.Collection', (Collection, App, Backbone, Marionette, $, _) ->

  class Collection.Notifications extends Backbone.Collection

    url: '/api/notifications'
