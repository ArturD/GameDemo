class Game
  constructor: ->
    @soundSystem = new SoundSystem()
    @soundSystem.ready =>
      @ready()
    @ready =>
      @soundSystem.ensure("default")
      window.setTimeout( =>
          @soundSystem.ensure("andante")
        , 1000)
      window.setTimeout( =>
          @soundSystem.ensure("andante")
        , 2000)
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
    localization.bindGame(@)
    

$ ->
  window.game = new Game()
  
  game.push(new Localization({
    miniX: 400,
    miniY: 300,
    mini: '/assets/game/fmini1.png',
    img: '/assets/game/f1.png',
    active: true
  }))
  
  game.push(new Localization({
    miniX: 100,
    miniY: 100,
    mini: '/assets/game/fmini1.png',
    img: '/assets/game/f1.png',
  }))
  
  game.push(new Localization({
    miniX: 800,
    miniY: 120,
    mini: '/assets/game/fmini1.png',
    img: '/assets/game/f1.png',
  }))
  
  game.push(new Localization({
    miniX: 770,
    miniY: 500,
    mini: '/assets/game/fmini1.png',
    img: '/assets/game/f1.png',
  }))
  
  game.ready =>
    $('.game-canvas').html('playing')
