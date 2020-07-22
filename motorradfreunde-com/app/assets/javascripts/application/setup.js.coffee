@Motorradfreunde = new Marionette.Application()

@Motorradfreunde.on 'start', ->
  Backbone.history.start
    pushState: true
