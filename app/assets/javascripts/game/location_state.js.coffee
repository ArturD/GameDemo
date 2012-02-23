class LocationState
  constructor: (params) ->
    @defaults()
    @elements = {}
    params ||= {}
    @params ||= {}
    for key of params
      if params[key] or params[key] == null
        @params[key] = params[key]

  defaults: ->
  
  enable: ->
    @params

  disable: ->

# make LocationState public
window.LocationState = LocationState
