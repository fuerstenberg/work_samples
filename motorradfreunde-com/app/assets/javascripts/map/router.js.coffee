@Motorradfreunde.module 'Application.Map', (Map, App, Backbone, Marionette, $, _) ->

  class Map.Router extends Marionette.AppRouter

    controller: new Map.Controller()

    appRoutes:
      'events':              'index'
      'motorradtreffen':     'index'
      'orte':                'index'
      'orte/t/:tag_id':      'index'
      'motorradtouren':      'index'
      'biker':               'index'
      'users':               'index'
      'routes':              'index'

      'events/new':               'form'
      'events/:id/edit':          'form'
      'motorradtreffen/new':      'form'
      'motorradtreffen/:id/edit': 'form'
      'orte/new':                 'form'
      'orte/:id/edit':            'form'

      'biker/:id':           'show'
      'biker/:id/dashboard': 'show'
      'orte/:id':            'show'
      'account':             'show'
      'account/users':       'show'
      'account/dashboard':   'show'
      'motorradtreffen/:id': 'show'
      'events/:id':          'show'
      'users/:id':           'show'
