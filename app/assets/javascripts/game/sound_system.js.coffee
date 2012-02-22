
class @SoundSystem
  constructor: ->
    soundManager.url = "/assets/"
    @sounds = []
    @ready =>
      @sounds['default'] = new Sound('default', '/assets/amelia14.ogg',{volume: 20})
      @sounds['andante'] = new Sound('andante', '/assets/andante.ogg')

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

    
