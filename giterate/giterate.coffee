exec = require("child_process").exec
colors = require "colors"

# TODO: Load from config file
config =
  root: "~/Projects"

# Gotta have these helpers...
log = (output) ->
  console.log output.toString().green

error = (error) ->
  console.error error.toString().red

# Do you really think I have time to type these eight characters every other minute?
h = "got here"

# Introducing some *nix magic...
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

# ...and some less magic parser code
class Parser

  @processPaths: (stdout) ->

    # Split into array
    paths = stdout.split "\n"

    # Strip '/.git'
    paths.map (path) ->
      path = path.slice 0, path.lastIndexOf "/"

Magic.cast Magic.spells.find, (err, stdout, stderr) ->
  paths = Parser.processPaths stdout

  for path in paths
    ritual = Magic.combine [
      # cd into path
      Magic.spells.cd(path)
      # git: add all files
      Magic.spells.git.add
      # git: commit (with or without message)
      Magic.spells.git.commit "To lazy to write a message"
      # git: pull
      Magic.spells.git.pull
      # git: push
      Magic.spells.git.push
    ]
    log ritual
    Magic.perform ritual, (err, stdout, stderr) ->
      log stdout
