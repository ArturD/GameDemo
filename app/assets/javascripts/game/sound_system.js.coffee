
class @SoundSystem
  constructor: ->
    soundManager.url = "/assets/"
    @sounds = []
    @ready =>
      @sounds['default'] = new Sound('default', '/assets/amelia14.ogg',{volume: 12})
      @sounds['s1a'] = new Sound('s1a', '/assets/1a.ogg',{volume: 25})
      @sounds['s1b'] = new Sound('s1b', '/assets/1b.ogg',{volume: 25})
      @sounds['s2a'] = new Sound('s2a', '/assets/2a.ogg',{volume: 25})
      @sounds['s2b'] = new Sound('s2b', '/assets/2b.ogg',{volume: 25})
      @sounds['s3'] = new Sound('s3', '/assets/3.ogg',{volume: 25})
      @sounds['s4a'] = new Sound('s4a', '/assets/4a.ogg',{volume: 25})
      @sounds['s5a'] = new Sound('s5a', '/assets/5a.ogg',{volume: 25})
      @sounds['s5b'] = new Sound('s5b', '/assets/5b.ogg',{volume: 25})
      @sounds['s5c'] = new Sound('s5c', '/assets/5c.ogg',{volume: 25})
      

  ready: (handler)->
    if handler != null
      soundManager.onready =>
        handler()

  ensure: (name)->
    if @current
      if @current.id != name
        @current.stop()
      else return @current
    @current = @sounds[name]
    @current.loop()

  play: (name)->
    @sounds[name].play()

  stop: (name)->
    @sounds[name].stop()

    
