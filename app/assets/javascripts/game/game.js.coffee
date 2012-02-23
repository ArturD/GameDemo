class Game
  constructor: ->
    @soundSystem = new SoundSystem()
    @soundSystem.ready =>
      @ready()
    @ready =>
      @soundSystem.ensure("default")
    @locations = []
    @actions = {}

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

  push: (location) ->
    @locations.push(location)
    location.bindGame(@, @locations.length-1)

  pushAction: (name, action) ->
    @actions[name] = action

  action: (name) ->
    Logger.error("no such action #{name}") if not @actions[name]
    @actions[name]()
  
  state: (location, state) ->
    @locations[i].state(state)

  goto: (i) ->
    @locations[i].select()
    $(window).scrollTo('.game-canvas', 1000)

$ ->
  window.game = new Game()
  
  game.push(new Location({
    miniX: 400,
    miniY: 300,
    mini: '/assets/game/f1mini.png',
    img: '/assets/game/f1.png',
    active: true
    states: {
      a: {
        text: 'Gdzie chcesz jechać? <br/><a href="do:f1_w_lewo">W LEWO</a><a href="do:f1_w_prawo">W PRAWO</a>'
      }
      b: {
        text: 'Gdzie teraz? <br/><a href="do:f1_w_lewo">W LEWO</a><a href="do:f1_w_prawo">W PRAWO</a>'
      }
    }
  }))
  
  game.pushAction "f1_w_prawo", =>
    game.state(0, 'b')
    

  game.push(new Location({
    miniX: 100,
    miniY: 100,
    mini: '/assets/game/f2mini.png',
    img: '/assets/game/f2.png',
    active: true,
    rotation: 13
  }))
  
  game.push(new Location({
    miniX: 850,
    miniY: 120,
    mini: '/assets/game/f3mini.png',
    img: '/assets/game/f3.png',
    rotation: -20
  }))
  
  game.push(new Location({
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
