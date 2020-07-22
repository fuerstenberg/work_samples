#= require jquery
#= require jquery.browser
#= require jquery_ujs
#= require jquery.ui.core
#= require jquery.ui.widget
#= require jquery.ui.mouse
#= require jquery.ui.position
#= require jquery.ui.draggable
#= require jquery.ui.droppable
#= require jquery.ui.sortable
#= require jquery.ui.slider
#= require jquery.cookies/jquery.cookies
#= require lightbox/jquery.lightbox.min
#= require masonry/masonry.min

#= require underscore/underscore
#= require backbone/backbone
#= require backbone.marionette/backbone.marionette
#= require richmarker/richmarker.min
#= require bootstrap-datepicker/js/bootstrap-datepicker
#= require bootstrap-datepicker/js/locales/bootstrap-datepicker.de
#= require countdown/countdown

#= require tether
#= require bootstrap-sprockets
#= require theme-twitter-bootstrap-application/dist/toolkit

#= require application/setup
#= require_tree ./application
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./templates
#= require_tree ./views
#= require_tree ./events
#= require_tree ./facebook
#= require_tree ./map
#= require_tree ./notifications
#= require_tree ./pois
#= require_tree ./ride_request
#= require_tree ./user_online_status
#= require_tree ./invite_facebook_friends
#= require_tree ./routes

$ =>
  @Motorradfreunde.start()
