$ ->
  resize = ->
    w = $(window).width()
    h = $(window).height()

    $('.game-canvas').css({
      height: "#{h}px"
      })
    $('.map-canvas').css({
      height: "#{h}px"
      })

  resize()
  $(window).resize(resize)
