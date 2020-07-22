class CMS.Views.Addresses.Map

  @start: ->
    for element in $('.map')
      new CMS.Views.Addresses.Map element


  constructor: (element) ->
    @$el = $ element
    @data = @$el.data()
    @latLng =
      lat: @data.lat
      lng: @data.lng

    mapOptions =
      center: @latLng
      scrollwheel: false
      zoom: 11

    # Create a map object and specify the DOM element for display.
    map = new google.maps.Map element, mapOptions

    # Create a marker and set its position.
    marker = new google.maps.Marker
      map: map
      position: @latLng
      title: 'Hello World!'
