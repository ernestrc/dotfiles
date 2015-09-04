{formatType, formatCompletionsSignature} = require '../lib/formatting'
{readFromString, fromLisp} = require '../lib/lisp/lisp'


describe 'formatCompletionsSignature', ->
  it "should format x, y -> z", ->
    inputParams = [[["x", "Int"], ["y", "Int"]]]
    result = formatCompletionsSignature(inputParams)

    expect(result).toBe("(${1:x: Int}, ${2:y: Int})")

  it "should format foo(asdf: Int, y: Int)", ->
    inputString =
        """
        {"name":"foo","typeId":2801,"typeSig":{"sections":[[["asdf","Int"],["y","Int"]]],"result":"Int"},"relevance":90,"isCallable":true}
        """
    json = JSON.parse(inputString)
    result = formatCompletionsSignature(json.typeSig.sections)
    console.log(result)
    expect(result).toBe("(${1:asdf: Int}, ${2:y: Int})")

  it "should format curried", ->
    sections =
       [
          [
            [
              "x",
              "Int"
            ]
          ],
          [
            [
              "y",
              "Int"
            ]
          ]
        ]

    result = formatCompletionsSignature(sections)
    console.log result
    expect(result).toBe("(${1:x: Int})(${2:y: Int})")


describe 'formatType', ->
  it "should use simple name for type param", ->
    typeStr = """
          {
            "name": "A",
            "fullName": "scalaz.std.A",
            "typehint": "BasicTypeInfo",
            "typeId": 37,
            "typeArgs": [],
            "members": [],
            "declAs": {
              "typehint": "Nil"
            }
          }
      """

    type = JSON.parse(typeStr)
    expect(formatType(type)).toBe("A")

  it "should use fullName for class type", ->
    typeStr = """
        {
            "name": "Thang",
            "fullName": "se.foo.bar.Thang",
            "pos": {
              "typehint": "OffsetSourcePosition",
              "file": "/Users/viktor/dev/projects/ensime-test-project/src/main/scala/se/foo/bar/Thang.scala",
              "offset": 31
            },
            "typehint": "BasicTypeInfo",
            "typeId": 689,
            "typeArgs": [],
            "members": [],
            "declAs": {
              "typehint": "Class"
            }
          }
      """
    type = JSON.parse(typeStr)
    expect(formatType(type)).toBe("se.foo.bar.Thang")


  it "should format by-name with arrow", ->
    type =
      "name": "<byname>",
      "fullName": "scala.<byname>",
      "typehint": "BasicTypeInfo",
      "typeId": 2861,
      "typeArgs": [
        {
          "name": "T",
          "fullName": "net.liftweb.util.T",
          "typehint": "BasicTypeInfo",
          "typeId": 2862,
          "typeArgs": [],
          "members": [],
          "declAs": {
            "typehint": "Nil"
          }
        }
      ],
      "members": [],
      "declAs": {
        "typehint": "Class"
      }
    expect(formatType(type)).toBe("=> T")
