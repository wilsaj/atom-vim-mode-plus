# Refactoring status: 100%
_ = require 'underscore-plus'

module.exports =
class CountManager
  count: null

  constructor: (@vimState) ->

  set: (e) ->
    num = if _.isNumber(e) then e else parseInt(@getKeystrokeForEvent(e))
    @count ?= 0
    @count = (@count * 10) + num
    @vimState.hover.add num

  get: ->
    @count

  reset: ->
    @count = null

  isEmpty: ->
    not @count

  getKeystrokeForEvent: (event) ->
    if event.originalEvent.originalEvent?
      console.log event.originalEvent.originalEvent
    # keyboardEvent = event.originalEvent.originalEvent ? event.originalEvent
    keyboardEvent = event.originalEvent
    atom.keymaps.keystrokeForKeyboardEvent(keyboardEvent)
