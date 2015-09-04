LogView = require './log-view'

module.exports =
class EnsimeServerUpdateLogView extends LogView
  @URI: "atom://ensime/server-update-log"

  constructor: ->
    super(title: "Ensime server update:")
