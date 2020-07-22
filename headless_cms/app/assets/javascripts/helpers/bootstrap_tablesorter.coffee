ready = ->
  $("[data-sort=table]").tablesorter
    # Sort on the second column, in ascending order
    sortList: [[0,0]]

$(document).ready(ready)
$(document).on('turbolinks:load', ready)
