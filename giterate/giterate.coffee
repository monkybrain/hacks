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
    list: "ls -la"
    git:
      add: "git add ."
      commit: (message) ->
        "git commit -a -m \"#{message}\""
      push: "git push -u --all"
      pull: "git pull --all"
      status: "git status"
    timerTest: "while true; do echo 'test'; sleep 5; done"

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
      # Not so elegant below...
      if args[0]? and args[1]?
        if args[0] is 'summon' and args[1] is 'daemon'
          return 'summon'
        if args[0] is 'dismiss' and args[1] is 'daemon'
          return 'dismiss'

  @paths: (stdout) ->

    # Split into array
    paths = stdout.trim().split "\n"

    # Strip '/.git'
    paths.map (path) ->
      path = path.slice 0, path.lastIndexOf "/"

### Flow ###
class Flow

  @init: () ->

    @running = false

    new Promise (resolve, reject) ->
      try
        data = fs.readFileSync 'giterate.json', 'utf8'
      catch err
        error "Cannot open giterate.json"
        reject()

      config = JSON.parse data

      # lay down a...
      # marker()

      # get command
      command = Parser.commands args

      if command is 'run'
        Flow.runOnce()
      if command is 'summon'
        Flow.start()

      resolve()

  # Run - jolt the daemon #
  @runOnce: () ->

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

  @start: () ->
    Flow.running = true
    log "\nDaemon has been summoned..."
    log "\nUse ctrl-c to dismiss him"
    setInterval () ->
      if Flow.running then Flow.runOnce()
    , min2ms(config.interval / 4)


# Init
Flow.init().then(
  # Run
  () -> Flow.run()
  # Error
  () -> error "Aborted..."
)