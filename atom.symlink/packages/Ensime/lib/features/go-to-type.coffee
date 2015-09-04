{bufferPositionFromMouseEvent} = require '../utils'
{formatType} = require '../formatting'
SubAtom = require 'sub-atom'

class GoToType
  constructor: (@editor, @client) ->
    @disposables = new SubAtom
    @editorElement = atom.views.getView(@editor).rootElement

    @disposables.add @editorElement, 'mousedown', '.scroll-view', (e) =>
      {detail, shiftKey, metaKey, ctrlKey, altKey} = e
      bufferPt = bufferPositionFromMouseEvent(@editor, e)
      if(altKey) then @client.goToTypeAtPoint(@editor.getBuffer(), bufferPt)

  deactivate: ->
    @disposables.dispose()


module.exports = GoToType
