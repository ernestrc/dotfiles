# Some parsing utilities, propbably buggy as hell, but works for the use cases I've seen so far

{fromLisp} = require './lisp'


typeIsArray = ( value ) ->
    value and
        typeof value is 'object' and
        value instanceof Array and
        typeof value.length is 'number' and
        typeof value.splice is 'function' and
        not ( value.propertyIsEnumerable 'length' )

arrToJObject = (x) ->

  parseObject = (obj) ->
    if not obj? || obj.length == 0
      {}
    else
      keyValue = obj.splice(0, 2)
      result = parseObject(obj)
      result[keyValue[0]] = arrToJObject(keyValue[1])
      result

  parseArray = (arr) ->
      arrToJObject elem for elem in arr

  if typeIsArray(x)
    firstElem = x[0]
    # An array with first element being ":label" is an object and an array of arrays is a real array, no?
    if typeof firstElem is 'string' && firstElem.startsWith(":")
      # An object
      parseObject(x)
    else
      parseArray(x)
  else
    x


# Oh noes, this is crap, but fuck it and wait for json protocol
sexpToJObject = (msg) ->
  that = this
  arr = fromLisp(msg) # This arrayifies the lisp cons-list
  arrToJObject(arr)


module.exports =
  sexpToJObject: sexpToJObject
  arrToJObject: arrToJObject
