class Sound
  constructor: (@id, @url, params)->
    params ||= {}
    params.id = @id
    params.url = @url
    @isplaying = false
    @sound = soundManager.createSound(params)
  
  loop: ->
    @isplaying = true
    @sound.play(
      onfinish: =>
        @loop()
    )

  play: ->
    @isplaying = true
    @sound.play(
      onfinish: =>
        @isplaying = false
    )
  
  stop: ->
    if @isplaying
      @isplaying = false
      @sound.stop()

# make Sound public
window.Sound = Sound
