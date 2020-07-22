@Motorradfreunde.module 'Application', (Application, App, Backbone, Marionette, $, _) ->

  class Application.Layout extends Marionette.Layout

    initialize: ->
      # @initializeBodyPadding()
      @initializeDropdowns()
      # @initializeMasonry()
      @initializeLightBox()
      @initializeHideFlashMessages()
      @initializeDisplayCommentForm()
      @initializeGoogleAnalytics()
      @initializeCalculationOfDistanceToMe()
      @initializeCalculationOfDistanceToTimeNow()
      # @initializeShareaholicButtons()

    # initializeBodyPadding: ->
    #   $('body').css 'padding-top', ($('nav.main-navigation').height() + $('nav.sub-navigation').height())

    initializeDropdowns: ->
      $('.dropdown-toggle').dropdown()


    initializeMasonry: ->
      for container in $('.masonry')
        options =
          itemSelector: $(container).data('itemSelector')
          isInitLayout: false
        window.msnry = new Masonry container, options
        listener = (msnryInstance, laidOutItems) =>
          $(container).hide().css('visibility', 'visible').fadeIn()
          msnryInstance.off 'layoutComplete', listener
          # msnryInstance.unbind 'layoutComplete'
        msnry.on 'layoutComplete', listener
        setTimeout =>
          msnry.layout()
        , 1000
        setTimeout =>
          msnry.layout()
        , 2000
        setTimeout =>
          msnry.layout()
        , 3000
        setInterval =>
          msnry.layout()
        , 5000
        msnry.layout()


    initializeLightBox: ->
      $('.lightbox').lightbox()


    initializeDisplayCommentForm: ->
      commentButtonElement = $('a.btn-display-comment')
      if commentButtonElement.length > 1
        commentButtonElement.click (event) ->
          event.preventDefault()
          $(this).siblings('.media_comment').show()
          $(this).hide()
      else
        commentButtonElement.hide()
        $('.media_comment').show()

    initializeHideFlashMessages: ->
      flash = $('#flash_message')
      if flash.length > 0
        setTimeout ->
          $('#flash_message').slideUp 400, this.remove
        , 5000


    initializeGoogleAnalytics: ->
      if window.location.host.indexOf('motorradfreunde.com') != -1
        window._gaq = window._gaq || []
        window._gaq.push(['_setAccount', 'UA-3996828-1'])
        window._gaq.push(['_trackPageview'])

        ga       = document.createElement('script')
        ga.type  = 'text/javascript'
        ga.async = true
        # ga.src   = (if 'https:' == document.location.protocol then 'https://ssl' else 'http://www') + '.google-analytics.com/ga.js'
        ga.src   = (if 'https:' == document.location.protocol then 'https://' else 'http://') + 'stats.g.doubleclick.net/dc.js';
        s        = document.getElementsByTagName('script')[0]
        s.parentNode.insertBefore(ga, s)


    initializeCalculationOfDistanceToMe: ->
      if gon.currentUser and gon.currentUser.latitude and gon.currentUser.longitude
        from = new google.maps.LatLng(gon.currentUser.latitude, gon.currentUser.longitude)
        for distanceTag in $('.distance_from_me_to')
          element = $(distanceTag)
          data = element.data()
          if data.latitude and data.longitude
            to   = new google.maps.LatLng(data.latitude, data.longitude)
            dist = google.maps.geometry.spherical.computeDistanceBetween(from, to)
            dist = "ca. #{Math.round(dist/1000)} km bis zu dir"
            element.html(dist)


    initializeCalculationOfDistanceToTimeNow: ->
      singular = 'Millisekunde|Sekunde|Minute|Stunde|Tag|Woche|Monat|Jahr|Jahrzent|Jahrhundert|Jahrtausend'
      plural = 'Millisekunden|Sekunden|Minuten|Stunden|Tagen|Wochen|Monaten|Jahren|Jahrzenten|Jahrhunderten|Jahrtausenden'
      countdown.setLabels singular, plural, 'und '

      calculateTime = =>
        now = (new Date()).getTime()
        for timeTag in $('.time_to_words')
          element = $(timeTag)
          time = element.data('time') * 1000
          if now > time
            prefix = 'vor etwa '
          else
            prefix = 'noch '
          element.html prefix + countdown(new Date(time),null,countdown.DEFAULTS,2).toString().replace(', and ', ' und ')

      calculateTime()
      setInterval calculateTime, 30000


    initializeShareaholicButtons: ->
      shr = document.createElement('script')
      shr.setAttribute('data-cfasync', 'false')
      shr.src = '//dsms0mj1bbhn4.cloudfront.net/assets/pub/shareaholic.js'
      shr.type = 'text/javascript'
      shr.async = 'true'
      shr.onload = shr.onreadystatechange = ->
        rs = this.readyState
        return if (rs && rs != 'complete' && rs != 'loaded')
        site_id = '4e1d6ba9230831b55210a5b91b2ec587'
        try
          Shareaholic.init(site_id)
        catch e
          console.log e
      s = document.getElementsByTagName('script')[0]
      s.parentNode.insertBefore(shr, s)


    # handleAdvertise: ->
    #   unless $('meta[property=current_user]').attr('content')
    #     $('.advertise').modal() if (location.pathname == "/" or location.pathname == "")
    #     $('body.list.index .main_item a').click (event) ->
    #       event.preventDefault()
    #       $('.advertise').modal()

    # closeBtnHandler: ->
    #   $('.message a.close').click ->
    #     $(this).parent().hide()
    #     $(this).closest('.message').hide()
