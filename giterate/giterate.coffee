exec = require("child_process").exec
colors = require "colors"

# TODO: Load from config file
config =
  root: "~/Projects"
  log: true

# Gotta have these helpers...
log = (output) ->
  if config.log
    console.log output.toString().green

error = (error) ->
  if config.log
    console.error error.toString().red

# Do you really think I have time to type these eight characters every other minute?
h = "got here"


# Introducing some (basic) *nix magic...

### MAGIC ###
class Magic

  @spells:
    cd: (dir) ->
      "cd #{dir}"
    find: "find #{config.root} -name .giterate -prune"
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

  @processPaths: (stdout) ->

    # Split into array
    paths = stdout.split "\n"

    # Strip '/.git'
    paths.map (path) ->
      path = path.slice 0, path.lastIndexOf "/"

### RUN ###
Magic.cast Magic.spells.find, (err, stdout, stderr) ->

  # Get paths
  paths = Parser.processPaths stdout

  # Perform ritual for each path
  for path in paths
    ritual = Magic.combine [
      # cd into path
      Magic.spells.cd(path)
      # git: add all files
      Magic.spells.git.add
      # git: commit (with or without message)
      Magic.spells.git.commit "Still hacking away at giterate"
      # git: pull
      Magic.spells.git.pull
      # git: push
      Magic.spells.git.push
    ]
    Magic.perform ritual, (err, stdout, stderr) ->
      error stderr
      log stdout
