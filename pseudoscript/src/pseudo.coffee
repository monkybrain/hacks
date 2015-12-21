yargs = require ("yargs")
readline = require "linebyline"
fs = require "fs"

sv =
  "for ": "för varje "    # TODO: Allow arrays
  "in ": "i "
  "console.log ": ["visa ", "skriv ut ", "meddela "]
  "er.": "ret är "
  ".": ["en är ", "et är ", "ens ", "ets ", "'s "]    # 's english equivalent
  "if": "^om"
  " if": " om"
  "  if": "  om"                  # Not very elegant
  "else": "annars"
  "''": "ingenting"
  "console.log('')": "<tom rad>"
  "": ["resultatet av att", "vem som", "denna"]
  "true": "ja"
  "false": "nej"
  "then ": "så "
  ">": "överstiger"
  "<": "understiger"
  "return": "svara med"
  "begränsa": pre: "begränsa", post: "till"   # Functions!
  # Math
  "*": "multiplicerat med"
  "+": "plus"
  "2": "två"
  "3": "tre"
  # Logic
  "and": "och"

d =
  "for": "for every"
  "lake": "the lake"
  # "<null>": "the"                 # TO BE IMPLEMENTED!
  "console.log": "show me"

# Get filename
args = yargs.argv._

filename = yargs.argv._[0]

if filename is undefined then filename = 'test/raw.pseudo'

class Parser

  constructor: (filename, dictionary) ->
    @filename = if filename? then filename else null
    @dictionary = if dictionary? then dictionary else null
    @parsed = []

  replace: (line, target, source, post) =>
    if post?
      line = line.replace post, ', '
    source = new RegExp "#{source}", 'g'
    target = "#{target}"
    line.replace source, target

  process: (line) =>
    for target, source of @dictionary
      if typeof source is 'string'
        line = @replace line, target, source
      if typeof source is 'object'
        if source instanceof Array
          for synonym in source
            line = @replace line, target, synonym
        else
          line = @replace line, target, source.pre, source.post
    @parsed.push line

  strip: =>
    @filename.slice 0, @filename.lastIndexOf '.'

  join: =>
    @parsed.join("\n") + "\n"

  print: =>
    console.log @filename

  apply: (filename, dictionary) =>

    if filename? then @filename = filename
    if dictionary? then @dictionary = dictionary

    # Existence tests
    ###if not @filename
      throw new Error 'Filename required'
    if not @dictionary
      throw new Error 'Dictionary required'###

    # Open stream
    try lines = readline filename
    catch error then console.error error

    # Handle each line
    lines.on 'line', (line) =>
      @process(line)

    # Write to file
    lines.on 'end', () =>
      data = "# Generated CoffeeScript from PseudoScript\n\n"
      data += @join()
      fs.writeFile @strip() + '.coffee', @join()

parser = new Parser
parser.apply filename, sv
