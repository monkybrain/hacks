exec = require("child_process").exec
args = require("yargs").argv._    # short hand for returning array of flagless arguments
colors = require "colors"
fs = require "fs"
Promise = require "promise"

# Config object
config = {}
intervalFunction = null

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

# Introducing some (very basic) *nix magic...

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
      pull: "git pull -u --all"
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
    # Not so elegant below...
    if args[0]?
      if args[0] is 'daemon' then return 'daemon'
      if args[0] is 'state' then return 'state'
      if args[0] is 'interval' then return 'interval'


  @paths: (stdout) ->

    # Split into array
    paths = stdout.trim().split "\n"

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
      # marker()

      # get command
      @command = Parser.commands args

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
          log "daemon: giterated at " + Date()
          # error stderr
          # log stdout

  # Summon him for real - don't be scared...
  @daemon: () ->
    log "\ndaemon: You summoned me?"
    log "\n(Use ctrl-c to dismiss him)\n"
    Flow.runOnce()
    intervalFunction = setInterval () ->
      Flow.runOnce()
    , min2ms(config.interval)

  @state: () ->
    if not args[1]?
      error "\ndaemon: empty inside, are we?\n"
      return
    config.state = args[1]
    # Write to file
    fs.writeFileSync 'giterate.json', JSON.stringify(config)
    log "daemon: state set to \"#{config.state}\""

  @interval: () ->
    if not args[1]?
      error "\ndaemon: does the concept of time confuse you?\n"
      return

    config.interval = parseInt args[1]
    if isNaN config.interval then return error "daemon: that's not right..."

    # Write to file
    fs.writeFileSync 'giterate.json', JSON.stringify(config)
    log "daemon: interval set to \"#{config.interval}\""

# Init
Flow.init().then(
  # Run
  () ->
    if @command is 'run'
      Flow.runOnce()
    if @command is 'daemon'
      Flow.daemon()
    if @command is 'state'
      Flow.state()
    if @command is 'interval'
      Flow.interval()
  # Error
  () -> error "Aborted..."
)

process.on 'SIGINT', () ->
  intervalFunction = null;
  log "\ndaemon: ok, retreating to the netherworld...\n"
  process.exit()