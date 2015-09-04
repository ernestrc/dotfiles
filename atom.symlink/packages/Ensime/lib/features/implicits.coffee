ImplicitInfo = require '../model/implicit-info'

class Implicits
  constructor: (@editor, @client) ->
    @gutter = @editor.gutterWithName "ensime-implicits"
    @gutter ?= @editor.addGutter
      name: "ensime-implicits"
      priority: 10

  showImplicits: ->
    b = @editor.getBuffer()
    range = b.getRange()
    startO = b.characterIndexForPosition(range.start)
    endO = b.characterIndexForPosition(range.end)

    msg =
      "typehint":"ImplicitInfoReq"
      "file": b.getPath()
      "range":
        "from": startO
        "to": endO

    @clearMarkers
    @client.post(msg, (result) =>
      console.log(result)

      createMarker = (info) =>
        range = [b.positionForCharacterIndex(parseInt(info.start)), b.positionForCharacterIndex(parseInt(info.end))]
        marker = @editor.markBufferRange(range,
            invalidate: 'inside'
            type: 'implicit'
            info: info
        )
        @editor.decorateMarker(marker,
            type: 'highlight'
            class: 'implicit'
        )
        # @gutter.decorateMarker(marker,
        #     type: 'line-number'
        #     class: 'implicit'
        # )


        marker
      markers = createMarker info for info in result.infos
    )

  showImplicitsAtCursor: ->
    pos = @editor.getCursorBufferPosition()
    markers = @findMarkers({type: 'implicit', containsBufferPosition: pos})
    markers.map (marker) =>
      overlayDecoration = @editor.decorateMarker(marker, {type: 'overlay', item: new ImplicitInfo(marker.info), position: 'head'})
    console.log(markers)

  clearMarkers: ->
    marker.destroy() for marker in @findMarkers()

  findMarkers: (attributes={type: 'implicit'}) ->
    @editor.getBuffer().findMarkers(attributes)

  deactivate: ->
    @clearMarkers()


# _.extend(attributes, class: 'bookmark')

module.exports = Implicits
