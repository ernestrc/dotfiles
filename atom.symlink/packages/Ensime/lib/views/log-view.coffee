{ScrollView} = require 'atom-space-pen-views'
$ = require 'jquery'

module.exports =
class LogView extends ScrollView

  @content: (params) ->
    @div class: 'ensime-log-view scroll-view native-key-bindings', tabIndex: -1, =>
      #@h1 class: 'panel-heading', params.title
      @ul class: 'list-group padded', outlet: "list"
  initialize: (params) ->
    @title = params.title

  addRow: (row) ->
    @list.append "<li>#{row}</li>"
  getTitle: ->
    @title

  getURI: ->
    @constructor.URI
