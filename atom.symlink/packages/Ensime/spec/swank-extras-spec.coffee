{sexpToJObject, arrToJObject} = require '../lib/lisp/swank-extras'
{readFromString, fromLisp} = require '../lib/lisp/lisp'

describe 'sexpToJObject', ->
  xit "should parse type-at-point response", ->
    input = """
    (:ok (:arrow-type nil :name "Ingredient$" :type-id 109 :decl-as object :full-name "se.kostbevakningen.model.record.Ingredient$" :type-args nil :members nil :pos (:type offset :file "/Users/viktor/dev/projects/kostbevakningen/src/main/scala/se/kostbevakningen/model/record/Ingredient.scala" :offset 3563) :outer-type-id nil))
    """
    result = sexpToJObject(readFromString(input))
    expect(true).toBe(true)

  xit "should parse code completion response", ->
    input = """
    (:prefix "te" :completions ((:name "test" :type-sig (((("x" "Int") ("y" "Int"))) "Int") :type-id 9 :is-callable t :relevance 90 :to-insert nil) (:name "text" :type-sig (nil "text$") :type-id 5 :is-callable nil :relevance 80 :to-insert nil) (:name "templates" :type-sig (nil "templates$") :type-id 3 :is-callable nil :relevance 80 :to-insert nil) (:name "Terminator" :type-sig (nil "Terminator$") :type-id 6 :is-callable nil :relevance 70 :to-insert nil) (:name "TextAreaLength" :type-sig (nil "Int") :type-id 4 :is-callable nil :relevance 70 :to-insert nil))))
    """
    result = sexpToJObject(readFromString(input))

    expect(true).toBe(true)

  it "should parse the problematic part of completion response", ->
    ###
    input = """
    (:type-sig (((("x" "Int") ("y" "Int"))) "Int") :type-id 9 :is-callable t :relevance 90 :to-insert nil)
    """
    ###
    input = """
    ((("x" "Int") ("y" "Int")))
    """
    ###
     arr1(arr2(arr2(x, Int), arr2(x, Int)))
    ###
    lisp = readFromString(input)
    arr = fromLisp(lisp)

    result = arrToJObject(arr)

    expect(result[0][0][0]).toBe("x")
    expect(result[0][1][1]).toBe("Int")

  it "should parse scala notes", ->
    input = """
    (:scala-notes (:is-full nil :notes ((:file "/Users/viktor/dev/projects/kostbevakningen/src/main/scala/se/kostbevakningen/model/record/Ingredient.scala" :msg "missing arguments for method test in object Ingredient; follow this method with `_' if you want to treat it as a partially applied function" :severity error :beg 4138 :end 4142 :line 105 :col 3))))
    """

    result = sexpToJObject(readFromString(input))
    console.log(result)
    expect(result[":scala-notes"][":notes"].length).toBe(1)
