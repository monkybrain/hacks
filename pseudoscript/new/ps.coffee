class Universe

  contains: []

class Noun extends Universe

  set: (property, value) ->

  get: (property, value) ->

  containedIn: []

class Light extends Noun

  state:
    'on': false
    'brightness': 45

  property:
    'color': null

l = new Light()

console.log l.state.on

# scopes
# top scope: universe

# god like syntax:
# let there be a house (called home)
# create room

