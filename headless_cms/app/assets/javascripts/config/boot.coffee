ready = ->
  CMS.Views.Addresses.Map.start()


$(document).ready ready
$(document).on 'turbolinks:load', ready
