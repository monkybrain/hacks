# PseudoScript dictionaries #

### Design principles ###

* New paradigm: language orientated rather than orient objected programming
* Cast spells!
* Make sure you can say it first
* Functions as verbs

### Natural language ###
```

# PseudoScript
verbs:
  turn on:
    type: accusative
    set: on
  turn off:
    type: accusative
    unset: on
  change:
    type: dative
    prep: to
  report:
    type: dative
    prep: to
nouns:
  light:
    state:
      on: no
    level:
      brightness: 50
  room:
    state:
      dark: yes
    level:
      light: 32
  TV:
    state:
      on: yes
article:
  the

# The following sentence
if the room is dark then turn on the light and report "Day's over mate, get some rest" to the owner

# should produce something like
if room.dark
  set(light, on)
  report("Day's over mate, get som rest", owner)
  
# Statements seperated by commas
if the room is dark then turn on the light, turn off the TV and report "Bed time!"

if room.dark
  set(light, on)
  unset(TV, on)
  report("Bed time!")
  
(START BY IMPLEMENTING SET/UNSET!)


# Contextual scopes
scope:
  light:
    index: 2   # or index

if room.dark
  set(light[2], on)
    

```

Example in Swedish
```
verbs:
  tänd:
    type: accusative
    set: på
  släck:
    type: accusative
    unset: på
  justera:
    type: accusative
    adjust: ljusstyrka
nouns:
  lampa:
    state:
      på: no
    lever:
      ljusstyrka: 50
    genus: n
  rum:
    state:
      mörkt: yes
    genus: t
adverb:
  delay:
    prep: om
    
    
om rummet är mörkt så tänd lampan och rapportera "Snart läggdags!" (om tio minuter)
```