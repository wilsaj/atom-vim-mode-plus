# Refactoring status: 100%

class FlashManager
  timeoutID: null
  marker: null

  constructor: (@vimState) ->
    {@editor} = @vimState

  flash: ({range, klass, timeout}, fn=null) ->
    @reset()

    @marker = @editor.markBufferRange range,
      invalidate: 'never',
      persistent: false

    fn?()

    @editor.decorateMarker @marker,
      type: 'highlight'
      class: klass

    @timeoutID = setTimeout  =>
      @reset()
    , timeout

  reset: ->
    @marker?.destroy()
    clearTimeout @timeoutID
    {@marker, @timeoutID} = {}

  destroy: ->
    @reset()
    {@vimState, @editor} = {}

module.exports = FlashManager
