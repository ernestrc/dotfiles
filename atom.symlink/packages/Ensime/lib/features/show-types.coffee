{TooltipView} = require '../views/tooltip-view'
$ = require 'jquery'
{bufferPositionFromMouseEvent, pixelPositionFromMouseEvent, getElementsByClass} = require '../utils'
{formatType} = require '../formatting'
SubAtom = require('sub-atom')


class ShowTypes
  constructor: (@editor, @client) ->
    @disposables = new SubAtom

    @editorView = atom.views.getView(@editor)
    @editorElement = @editorView.rootElement

    @disposables.add @editorElement, 'mousemove', '.scroll-view', (e) =>
      @clearExprTypeTimeout()
      @exprTypeTimeout = setTimeout (=>
        @showExpressionType e
      ), 100

    @disposables.add @editorElement, 'mouseout', '.scroll-view', (e) =>
      @clearExprTypeTimeout()

    @disposables.add @editor.onDidDestroy =>
      @deactivate()


  # get expression type under mouse cursor and show it
  showExpressionType: (e) ->
    return if @exprTypeTooltip?

    pixelPt = pixelPositionFromMouseEvent(@editor, e)
    bufferPt = bufferPositionFromMouseEvent(@editor, e)
    nextCharPixelPt = @editorView.pixelPositionForBufferPosition([bufferPt.row, bufferPt.column + 1])

    return if pixelPt.left >= nextCharPixelPt.left

    # find out show position
    rectOffset = @editor.getLineHeightInPixels() * 0.7
    tooltipRect =
      left: e.clientX
      right: e.clientX
      top: e.clientY - rectOffset
      bottom: e.clientY + rectOffset

    # create tooltip with pending
    @exprTypeTooltip = new TooltipView(tooltipRect)


    textBuffer = @editor.getBuffer()
    offset = textBuffer.characterIndexForPosition(bufferPt)

    req =
      typehint: "SymbolAtPointReq"
      #typehint: "TypeAtPointReq"
      file: @editor.getPath()
      point: offset

    @client.post(req, (msg) =>
      if msg.typehint == 'SymbolInfo'
        @exprTypeTooltip?.updateText(formatType(msg.type))
      else
        # if msg.typehint == 'FalseResponse'
        # do nothing
    )

  deactivate: ->
    @clearExprTypeTimeout()
    @disposables.dispose()

  # helper function to hide tooltip and stop timeout
  clearExprTypeTimeout: ->
    if @exprTypeTimeout?
      clearTimeout @exprTypeTimeout
      @exprTypeTimeout = null
    @hideExpressionType()

  hideExpressionType: ->
    if @exprTypeTooltip?
      @exprTypeTooltip.remove()
      @exprTypeTooltip = null

module.exports = ShowTypes
