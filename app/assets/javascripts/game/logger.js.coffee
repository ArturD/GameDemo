class Logger
  @trace: (o) ->
    null
  @log: (o) ->
    @entry(o).prependTo($('.log-panel'))
  @debug: (o) ->
    @log(o).addClass('debug')
  @error: (o) ->
    @log(o).addClass('error')
    alert(@format(o))
  @entry: (o) ->
    $('<div class="log-entry">').text("> #{@format(o)}")
  @format: (o) ->
    if o.to_s
      o.to_s()
    else
      JSON.stringify(o)
