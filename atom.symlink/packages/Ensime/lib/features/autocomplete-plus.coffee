{formatCompletionsSignature} = require '../formatting'

module.exports =
class AutocompletePlusProvider
  constructor: (@client) ->

  getCompletions: (textBuffer, bufferPosition, callback) =>
    file = textBuffer.getPath()
    offset = textBuffer.characterIndexForPosition(bufferPosition)

    msg =
      typehint: "CompletionsReq"
      fileInfo:
        file: file
        contents: textBuffer.getText()
      point: offset
      maxResults: 5
      caseSens: false
      reload: true

    @client.post(msg, (result) ->
      completions = result.completions

      if(completions)
        translate = (c) ->
          typeSig = c.typeSig
          if(c.isCallable)
            formattedSignature = formatCompletionsSignature(typeSig.sections)
            {leftLabel: c.typeSig.result, snippet: "#{c.name}#{formattedSignature}"}
          else
            {snippet: c.name}

        autocompletions = (translate c for c in completions)
        ### Autocomplete + :
        suggestion =
          text: 'someText' # OR
          snippet: 'someText(${1:myArg})'
          replacementPrefix: 'so' # (optional)
          type: 'function' # (optional)
          leftLabel: '' # (optional)
          leftLabelHTML: '' # (optional)
          rightLabel: '' # (optional)
          rightLabelHTML: '' # (optional)
          iconHTML: '' # (optional)
        ###
        callback(autocompletions)
    )
