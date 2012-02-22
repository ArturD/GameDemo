class Game
  constructor: ->
    @soundSystem = new SoundSystem()
    @soundSystem.ready =>
      @ready()
    @ready =>
      @soundSystem.ensure("default")
    @localizations = []

  ready: (handler)->
    @handlers ||= []
    if @isready == true
      if handler
        handler()
      return
    if handler
      @handlers.push(handler)
    else
      @isready = true
      for handle in @handlers
        handle()

  push: (localization) ->
    @localizations.push(localization)
    localization.bindGame(@, @localizations.length-1)
  
  goto: (i) ->
    @localizations[i].select()
    $(window).scrollTo('.game-canvas', 1000)

$ ->
  window.game = new Game()
  
  game.push(new Localization({
    miniX: 400,
    miniY: 300,
    mini: '/assets/game/f1mini.png',
    img: '/assets/game/f1.png',
    active: true

  }))
  
  game.push(new Localization({
    miniX: 100,
    miniY: 100,
    mini: '/assets/game/f2mini.png',
    img: '/assets/game/f2.png',
    active: true,
    rotation: 13
  }))
  
  game.push(new Localization({
    miniX: 850,
    miniY: 120,
    mini: '/assets/game/f3mini.png',
    img: '/assets/game/f3.png',
    rotation: -20
  }))
  
  game.push(new Localization({
    miniX: 820,
    miniY: 500,
    mini: '/assets/game/f4mini.png',
    img: '/assets/game/f4.png',
    rotation: 12
  }))
  
  $('.map_link').click(=>
      $(window).scrollTo('.map-canvas', 1000)
    )

  game.ready =>
    game.goto(0)
