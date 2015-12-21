objects =
  lightObject:
    self: 'lightObject'
    name: 'light'
    properties:
      'on': false
      'brightness': 20
      'timer': 50

dictionary =
    verbs: [
      {phrase: "turn on", function: "Modify.set", property: 'on', value: true},
      # {phrase: /set\s\w*\sto/, function: "Modify.set", value: null}
      {phrase: /set\s.*\sto/, function: "Modify.set", value: null}
    ]

construct = (dictionary, objects) ->
  # Add nouns
  dictionary.nouns = []
  for key, value of objects
    dictionary.nouns.push {name: value.name, object: value}
  dictionary

module.exports =
  dictionary: construct(dictionary, objects)
  objects: objects
