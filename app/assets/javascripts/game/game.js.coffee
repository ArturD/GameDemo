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
    @locations[location].state(state)

  lactivate: (location) ->
    @locations[location].active = true
    @locations[location].inactiveMiniature.hide()
    @locations[location].activeMiniature.show()
    

  goto: (i) ->
    if @currentLocation
      @currentLocation.deselect()
    @currentLocation = @locations[i]
    @currentLocation.select()
    $(window).scrollTo('.game-canvas', 1000)

$ ->
  window.game = new Game()
  
  game.push(new Location({
    miniX: 400,
    miniY: 300,
    mini: '/assets/game/f1mini.png',
    img: '/assets/game/f1.png',
    active: true,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: '<br/>Jedziemy w lewo, czy w prawo? <br/><br/><a href="do:f1_w_lewo">W LEWO</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="do:f1_w_prawo">W PRAWO</a>',
        sound: 's1a'
      })
      b: new LocationState({
        text: '<br/>Gdzie teraz? <br/><br/><a href="do:f1_w_lewo">W LEWO</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="do:f1_w_prawo">W PRAWO</a>',
        sound: 's1b'
      })
      c: new LocationState({
        text: '<br/><br/><a href="do:mapa">MAPA</a>'
        sound: null
      })
    },
  }))

  game.pushAction "mapa", =>
    $(window).scrollTo('.map-canvas', 1000)
  
  game.pushAction "f1_w_prawo", =>
    game.state(0, 'b')
    game.lactivate(3)
    game.goto(3)

  game.pushAction "f1_w_lewo", =>
    game.state(0, 'b') 
    game.lactivate(1)   
    game.goto(1)

  game.push(new Location({
    miniX: 100,
    miniY: 100,
    mini: '/assets/game/f2mini.png',
    img: '/assets/game/f2.png',
    active: false,
    rotation: 13,
    activeState: 'a'
    states: {
      a: new LocationState({
        text: '<br/>Wtorek, piątek, czy sobota?<br/><br/><a href="do:f2_wtorek_piatek">WTOREK</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="do:f2_wtorek_piatek">PIĄTEK</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="do:f2_sobota">SOBOTA</a>'
        sound: 's2a'
      })
      b: new LocationState({
        text: '<br/><br/>Widzimy się w sobotę!<br/><br/><a href="do:mapa">MAPA</a>'
        sound: 's2b'
      })
      c: new LocationState({
        text: '<br/><br/><a href="do:mapa">MAPA</a>'
        sound: null
      })
    },
  }))

  game.pushAction "f2_wtorek_piatek", =>
    game.state(0, 'c')
    game.state(1, 'c')
    game.state(3, 'b')
    game.lactivate(2) 
    game.goto(2)

  game.pushAction "f2_sobota", =>
    game.state(1, 'b')
    game.goto(1)
  
  game.push(new Location({
    miniX: 70,
    miniY: 430,
    mini: '/assets/game/f3mini.png',
    img: '/assets/game/f3.png',
    active:false,
    rotation: -20,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: '<br/><br/><br/>Gościu, nie żyjesz.'
        sound: 's3'
      })
    },
  }))
  
  game.push(new Location({
    miniX: 850,
    miniY: 120,
    mini: '/assets/game/f4mini.png',
    img: '/assets/game/f4.png',
    active:false,
    rotation: 12,
    activeState: 'a',
    states: {
      a: new LocationState({
        text: '<br/>Chcesz spotkać się z twórcą gry? <br/><br/><a href="do:f4_tak">TAK</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="do:f4_nie">NIE</a>'
        sound: 's4a'
      })
      b: new LocationState({
        text: '<br/><br/><a href="do:mapa">MAPA</a>'
        sound: null
      })
    },
  }))

  game.pushAction "f4_tak", =>
    game.state(3, 'b')
    game.lactivate(4) 
    game.goto(4)

  game.pushAction "f4_nie", =>
    game.state(3, 'b')
    game.goto(3)

  game.push(new Location({
    miniX: 850,
    miniY: 440,
    mini: '/assets/game/f5mini.png',
    active:false,
    rotation: 12,
    activeState: 'a'
    states: {
      a: new LocationState({
        text: '<br/>Podobało Ci się? <br/><br/><a href="do:f5_tak">TAK</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="do:f5_nie">NIE</a>',
        img: '/assets/game/f5a.png'
        sound: 's5a'
      })
      b: new LocationState({
        text: '<br/><br/>Dzięki! Świetnie!<br/><br/><a href="do:mapa">MAPA</a>'
        img: '/assets/game/f5b.png'
        sound: 's5b'
      })
      c: new LocationState({
        text: '<br/><br/>Buuuu!<br/><br/><a href="do:mapa">MAPA</a>'
        img: '/assets/game/f5c.png'
        sound: 's5c'
      })
    },
  }))

  game.pushAction "f5_tak", =>
    game.state(4, 'b')
    game.goto(4)

  game.pushAction "f5_nie", =>
    game.state(4, 'c')
    game.goto(4)
  
  $('.map_link').click(=>
      $(window).scrollTo('.map-canvas', 1000)
    )
  $('a').live('click', (e) ->
    href = $(this).attr('href')
    if href.substr(0,3) == "do:"
      e.preventDefault()
      action = href.substr(3)
      game.action(action)
  )
  game.ready =>
    game.goto(0)
