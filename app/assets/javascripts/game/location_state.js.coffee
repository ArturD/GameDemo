class LocationState
  constructor: (params) ->
    @defaults()
    @elements = {}
    params ||= {}
    @params ||= {}
    for key of params
      if params[key]
        @params[key] = params[key]

  defaults: ->
  
  enalble: ->
    @params

  disable: ->

# make LocationState public
window.LocationState = LocationState
