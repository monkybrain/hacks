argv = require("yargs").argv
shell = require "shelljs/global"
colors = require "colors"
# exec = require "exec"
exec = require("child_process").exec

# Example of problem I will be able to solve with pseudoscript -> create own dialect
log = (output) ->
  console.log output

error = (error) ->
  console.error "#{error}".red

# Cast spell
cast = (spell, callback) ->
  exec spell, callback

spell = (commands) ->
  commands.join " && "

### COMMANDS ###
commands =

  ### COMMIT ###
  commit: (modifier) ->
    if not which "git"
      error "Error: git not installed"
    else
      find = ["find ~ -name .git -type d -prune"]
      cast spell(find), (err, stdout, stderr) ->

        # parse paths
        paths = stdout.trim().split("\n").map (path) ->
          path.slice 0, path.lastIndexOf "/"
        dirs = paths.map (path) ->
          dir = path.slice path.lastIndexOf("/")
          dir.slice 1

        # TODO: UGLY!
        if modifier?
          modifier is 'here'
          paths = ["."]

        # cd into each path
        index = 0
        for path in paths
          kermit = [
            "cd #{path}"
            "git add ."
            "git commit -m \"#{message}\""
            "git push -u --all"
          ]
          cast spell(kermit), (err, stdout, stderr) ->
            if stderr isnt ''
              error dirs[index++] + ": " + stderr
            else
              log dirs[index++] + ": ok"

    # COMING:
    # all: does what above does
    # here: commits in .
    # interval: commits and pushes at certain interval (with same message, "working on fix for ....")
      # - function that converts min to ms etc "pseduo interval 10 minutes" -> min2ms(10) -> 600000
    # state: this is how to set message mentioned above
    # last bit is giterature!


# Get argument
if argv._[0]?
  modifier = null
  args = argv._
  command = args[0]
  messageIndex = 1
  if args[1]?
    modifier = args[1]
    if modifier is 'all'
      messageIndex = 2
    if modifier is 'here'
      messageIndex = 2

  message = if args[1] then args[1] else 'pseudo-tools: testing standard message'

  console.log command

if command is 'commit'
  commands.commit modifier


# pseudoscript: bringing magic to the people..."

# missions statement..."

# unix commands look like old greek or something. i have to acknowledge my love for them