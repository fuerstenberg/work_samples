@Motorradfreunde.module 'Application.Model', (Model, App, Backbone, Marionette, $, _) ->

  class Model.ActiveRecord extends Backbone.Model

    wrapParameters: undefined

    toJSON: ->
      if @wrapParameters
        data = {}
        data[@wrapParameters] = super
        data
      else
        super
