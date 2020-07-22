ready = ->
  $('.dropdown-toggle').dropdown()

$(document).ready(ready)
$(document).on('turbolinks:load', ready)
