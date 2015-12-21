fs = require "fs"
readline = require "linebyline"

# Name of project? Santa Clauses?

type = (object) ->
  if typeof object is 'boolean'
    # return 'binary'
    return 'absolute'
  if typeof object is 'number'
    # return 'scale'
    return 'relative'


# Euro instead of dollar sign? € = 'fisk'; console.log €

# Basic functions
class Arithmetic # TODO: CREATE THIS CLASS
  @add: (a, b) ->
    a + b

multiply = (a, b) ->
  a * b

add = (a, b) ->
  a + b

set = (object, property, value) ->
  if typeof value is typeof object.properties[property]
    object.properties[property] = value
  else
    console.error "Error! Property '#{property}' of '#{object.name}' is #{type object.properties[property]}, not #{type value}"

unset = (object, property, value) ->
  object[property] = value

present = (information) ->
  console.log information

# Absolute
class Modify

  @match: (object, property, value) ->
    typeof value is typeof object.properties[property]

  @error: (object, property, value) ->
    console.error "Error! Property '#{property}' of '#{object.name}' is #{type object.properties[property]}, not #{type value}"

  @set: (object, property, value) ->
    if @match object, property, value
      object.properties[property] = value
    else
      @error object, property, value


tree =
  length: 3.5
  age: 43

# pseudo: take length of tree, multiply by three, add four and show me the result

present(Arithmetic.add(multiply(tree.length, 3), 4))

# Notice the reverse order (tree->multiply->add->present)

light =
  name:
    'light'
  properties:
    'on': false
    'brightness': 20

# Test set/unset
###
console.log "Before:"
console.log light
###

# pseudo: turn on light and set brightness to 45
Modify.set light, 'on', true
Modify.set light, 'brightness', 45

present light

# Error
Modify.set light, 'brightness', false

# Synonyms above: turn on (set absolute), set <prop> to (set relative), acrtivate (set absolute)

d =
  "Modify.set": "turn on"

lines = readline 'sub.pseudo'
lines.on 'line', (line) ->
  subclauses = line.split(',')
  present subclauses

