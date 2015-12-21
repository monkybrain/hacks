child = require "child_process"
exec = child.exec
spawn = child.spawn
args = require("yargs").argv._    # short hand for returning array of flagless arguments
colors = require "colors"
fs = require "fs"
Promise = require "promise"

# Config object
config = {}

# Gotta have these helpers...
log = (output) ->
  if config.log
    console.log output.toString().green

error = (error) ->
  if config.log
    console.error error.toString().red

# Do you really think I have time to type these eight characters every other minute?
marker = () ->
  log "got here"

min2ms = (min) ->
  min * 60 * 1000

# Introducing some (basic) *nix magic...

### MAGIC ###
class Magic

  @spells:
    cd: (dir) ->
      "cd #{dir}"
    find: (root) ->
      "find #{root} -name .giterate -prune"
    test: "ls -la"
    git:
      add: "git add ."
      commit: (message) ->
        "git commit -a -m \"#{message}\""
      push: "git push -u --all"
      pull: "git pull --all"
      status: "git status"

  @combine: (array) ->
    array.join " && "

  @cast: (spell, callback) ->
    exec spell, callback

  @perform: (ritual, callback) ->
    @cast ritual, callback

# ...and some parser code

### PARSER ###
class Parser

  @commands: (args) ->
    # if no command -> run once
    if args.length is 0
      return 'run'
    else
      if args.length > 1
        log "fisk"
        return args[0] + args[1]

  @paths: (stdout) ->

    # Split into array
    paths = stdout.split "\n"

    # Strip '/.git'
    paths.map (path) ->
      path = path.slice 0, path.lastIndexOf "/"

### Flow ###
class Flow

  @init: () ->
    new Promise (resolve, reject) ->
      try
        data = fs.readFileSync 'giterate.json', 'utf8'
      catch err
        error "Cannot open giterate.json"
        reject()

      config = JSON.parse data

      # lay down a...
      marker()

      # get command
      log Parser.commands args

      resolve()

  # Run #
  @run: () ->

    # Cast first spell : find project folders #
    Magic.cast Magic.spells.find(config.root), (err, stdout, stderr) ->

      # Get paths
      paths = Parser.paths stdout

      # Create ritual
      for path in paths
        ritual = Magic.combine [
          # cd into path
          Magic.spells.cd(path)
          # git: add all files
          Magic.spells.git.add
          # git: commit (with or without message)
          Magic.spells.git.commit config.state
          # git: pull
          Magic.spells.git.pull
          # git: push
          Magic.spells.git.push
        ]

        # Perform ritual for each project
        Magic.perform ritual, (err, stdout, stderr) ->
          error stderr
          log stdout

# Init
Flow.init().then(
  # Run
  () -> Flow.run()
  # Error
  () -> error "Aborted..."
)