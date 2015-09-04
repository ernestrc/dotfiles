{View} = require 'atom-space-pen-views'

# View for the little status messages down there where messages from Ensime server can be shown
module.exports =
  class StatusbarView extends View
    @content: ->
      @div class: 'ensime-status inline-block'

    initialize: ->

    serialize: ->

    init: ->
      @attach()

    attach: =>
      #statusbar = atom.workspaceView.statusBar # This is deprecated. Depend on status-bar package for injection
      #"In the future, this problem will be solved by an inter-package communication API available on atom.services. For now, you can get a reference to the status-bar element via document.querySelector('status-bar')."
      statusbar = document.querySelector('status-bar')
      statusbar?.addLeftTile {item: this}

    setText: (text) =>
      @text("Ensime: #{text}").show()

    destroy: ->
      @detach()
