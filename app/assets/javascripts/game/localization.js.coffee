class Localization
  constructor: (params) ->
    @defaults()
    @elements = {}
    params ||= {}
    for key of params
      if params[key]
        @[key] = params[key]
  defaults: ->
    @miniX = 400
    @miniY = 400
    @mini = "/assets/game/fmini1.png"
    @inactiveMini = "/assets/game/tv.png"
    @img = "/assets/game/f1.png"
    @active = false

  bindGame: (@game) ->
    if @active
      e = @createActive()
    else
      e = @createInactive()

    $('.map-canvas').append(e)
  
  createInactive: ->
    e = @elements.mini = $('<img class="mini" src="'+@inactiveMini+'">')
    e.css(
      top: @miniY+60
      left: @miniX+30
    )

  createActive: ->
    e = @elements.mini = $('<img class="mini" src="'+@mini+'">')
    e.css(
      top: @miniY
      left: @miniX
    )
    step = (a,b)=>
      e.css({'WebkitTransform': "rotate(#{a*(-15)}deg) scale(#{1+a*0.1})"})
    stepM = (a,b)=>
      e.css({'WebkitTransform': "rotate(#{a*(-15)}deg) scale(#{1+a*0.1})"})
    stepW = (a,b)=>
      e.css({'WebkitTransform': "rotate(#{a*(-15)}deg) scale(#{1+a*0.1})"})
        
    e.hover((ev) =>
        e.animate({"_focus": 1}, step: step, duration:1000)
      , (ev) =>
        e.animate({"_focus": 0}, step: step, duration: 1000)
        )

#make localization public
window.Localization = Localization
