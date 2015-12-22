class Parser

  constructor: (map, dictionary) ->
    @map = map
    @dictionary = dictionary

    # Set scope to universe
    @scope = 'universe'

  parse: (line) ->

    ### Remove ignored words ###
    for word in @dictionary.ignore
      line = line.replace "#{word} ", ""

    ### VERB PHRASE ###
    vp =
      verb: null
      object: null
      indirect: null
      ref: ''

    ### Find reference ###
    match = line.match /called '.*'/
    if match?
      phrase = line.slice match.index
      vp.ref = phrase.replace("called", "").trim()


    ### Find indirect object ###
    for entry, body of @dictionary.prepositions
        for pattern in body.patterns
          match = line.match pattern
          if match?
            # Unuglify!!!
            phrase = line.slice(match.index)
            line = line.slice 0, line.lastIndexOf(phrase)
            indirect = phrase.slice pattern.length + 1
            for model in @map.concretes
              match = indirect.match model.lexical.word
              if match?
                if model.scope?
                  vp.indirect = model.scope
                else
                  vp.indirect = null
                break

    ### Find object ###
    for model in @map.concretes
      match = line.match model.lexical.word
      if match?
        vp.object = model
        break

    ### Find verb ###
    for entry, body of @dictionary.verbs
      for pattern in body.patterns
        match = line.match body.pattern
        if match?
          vp.verb = body.syntax
          break

    if vp.verb?
      return vp.verb(@scope, vp.object, vp.ref, vp.indirect)

  wrap: (lines, comments, path) ->

    # New document
    document = []

    # Header
    document.push "\n### Generated by PseudoScript 0.0.1 ###\n"

    # Imports
    document.push "\n### Imports ###"
    document.push "map = require '#{path}'"
    document.push "\n# Abstracts #"
    document.push "Universe = map.abstracts.Universe"
    document.push "Noun = map.abstracts.Noun"
    document.push "\n# Concretes #"
    document.push "Room = map.concretes[0]"
    document.push "Light = map.concretes[1]"

    document.push "\n\n\n### Code ###\n"

    document.push "# So you think you're god..."
    document.push "universe = new Universe()\n"

    # Combine comments and code
    combined = []
    for i in [0...comments.length]
      combined.push "# #{comments[i]}\n#{lines[i]}\n"

    # Push body
    document.push combined.join "\n"

    # Join and return
    document.join "\n"

    # TODO: Pull from source file instead!
    ###
    for model in @map.abstracts
      console.log model.toString()
    for model in @map.concretes
      console.log model.toString()
    ###

module.exports = Parser