# takes a callback and returns a debounced version
window.debounce = (callback, delay = 300) ->
  timeout = null
  return () ->
    args = Array.prototype.slice.call(arguments)
    if timeout?
      clearInterval(timeout)
    timeout = setTimeout((() ->
      callback.apply(this, Array.prototype.slice.call(args))
      timeout = null
    ), delay)
