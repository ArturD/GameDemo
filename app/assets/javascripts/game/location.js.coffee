class Location
  constructor: (params) ->
    @defaults()
    @elements = {}
    params ||= {}
    for key of params
      if params[key]
        @[key] = params[key]
    @states ||= {}
    if params.activeState
      @activeState = false
      @state(params.activeState)

  defaults: ->
    @miniX = 400
    @miniY = 400
    @mini = "/assets/game/fmini1.png"
    @inactiveMini = "/assets/game/tv.png"
    @img = "/assets/game/f1.png"
    @active = false
    @rotation = -15
    @scaleup = 0.1
    @text = "lorem ipsum"
    @sound = null

  bindGame: (@game, @id) ->
    @activeMiniature = @createActive()
    @inactiveMiniature = @createInactive()
    if @active
      @inactiveMiniature.hide()
    else
      @activeMiniature.hide()

    $('.map-canvas').append(@activeMiniature)
    $('.map-canvas').append(@inactiveMiniature)
  
  state: (activeState) ->
    return @activeState if @activeState == activeState
    @states[@activeState].disable() if @activeState
    @disableSound()
    @activeState = activeState
    params = @states[@activeState].enable()
    if params.text
      @text = params.text
    if params.img
      @img = params.img
    if params.sound or params.sound == null
      @sound = params.sound

  select: ->
    e = $('<img>').attr({src: @img})
    
    $('.location')
      .html('')
      .append(e)

    $('.subs').html(@text)
    if @sound
      @game.soundSystem.play(@sound)

  deselect: ->
    @disableSound()

  disableSound: ->
    if @sound
      @game.soundSystem.stop(@sound)
  
  createInactive: ->
    e = @elements.mini = $('<img class="mini" src="/assets/game/tv.png">')
    e.css(
      top: @miniY+60
      left: @miniX+30
    )
    
    step = (a,b)=>
      a = Math.sin(a*2)*2
      e.css({'transform': "rotate(#{a}deg)"})
    stepW = (a,b)=>
      a = Math.sin(a*2)*2
      e.css({'WebkitTransform': "rotate(#{a}deg)"})
    stepM = (a,b)=>
      a = Math.sin(a*2)*2
      e.css({'MozTransform': "rotate(#{a}deg)"})
    stepO = (a,b)=>
      a = Math.sin(a*2)*2
      e.css({'OTransform': "rotate(#{a}deg)"})
    stepE = (a,b)=>
      a = Math.sin(a*2)*2
      e.css({'MsTransform': "rotate(#{a}deg)"})
    step = stepW if $.browser.webkit
    step = stepM if $.browser.mozilla
    step = stepO if $.browser.opera
    step = stepE if $.browser.msie
    e.hover((ev) =>
        e.animate({"_shake": 20}, step: step, duration:1000)
      , (ev) =>
        e.css({"_shake": 0})
        #e.animate({"_shake": 0}, step: step, duration: 1000)
        )

  createActive: ->
    e = @elements.mini = $('<img class="mini" src="'+@mini+'">')
    e.css(
      top: @miniY
      left: @miniX
    )
    step = (a,b)=>
      e.css({'transform': "rotate(#{a*(@rotation)}deg) scale(#{1+a*@scaleup})"})
    stepW = (a,b)=>
      e.css({'WebkitTransform': "rotate(#{a*(@rotation)}deg) scale(#{1+a*@scaleup})"})
    stepM = (a,b)=>
      e.css({'MozTransform': "rotate(#{a*(@rotation)}deg) scale(#{1+a*@scaleup})"})
    stepO = (a,b)=>
      e.css({'OTransform': "rotate(#{a*(@rotation)}deg) scale(#{1+a*@scaleup})"})
    stepE = (a,b)=>
      e.css({'MsTransform': "rotate(#{a*(@rotation)}deg) scale(#{1+a*@scaleup})"})
    step = stepW if $.browser.webkit
    step = stepM if $.browser.mozilla
    step = stepO if $.browser.opera
    step = stepE if $.browser.msie

    e.hover((ev) =>
        e.animate({"_focus": 1}, step: step, duration:1000)
      , (ev) =>
        e.animate({"_focus": 0}, step: step, duration: 1000)
        )
    e.click(=>
      @game.goto(@id)
    )

#make localization public
window.Location = Location
