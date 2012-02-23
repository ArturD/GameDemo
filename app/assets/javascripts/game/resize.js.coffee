$ ->
  resize = ->
    w = $(window).width()
    h = $(window).height()

    scale = h/820
    translate = -(820 - h)/2

    $('.game-container, .map-container').css({
      height: "#{h}px"
    })
    $('.game-canvas, .map-canvas').css({
      height: "820px"
      transform: "translateY(#{translate}px) scale(#{scale})"
      'transform-origin': '50% 0'
      })

  resize()
  $(window).resize(resize)
  window.setTimeout(->
      resize()
    , 1)
