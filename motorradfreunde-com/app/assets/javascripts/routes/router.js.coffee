@Motorradfreunde.module 'Application.Route', (Route, App, Backbone, Marionette, $, _) ->

  class Route.Router extends Marionette.AppRouter

    controller: new Route.Controller()

    appRoutes:
      'motorradtouren/new':        'new'
      'account/routes/:id':        'show'
      'users/:user_id/routes/:id': 'show'
      'biker/:user_id/routes/:id': 'show'
      'routes/:id':                'show'
      'motorradtouren/:id':        'show'
