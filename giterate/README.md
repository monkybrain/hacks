# giterate #

rapid, automatic git iterations

### Use ###
```
# 1) Add a .giterate file to the root of your project folder.

-> touch .giterate

# 2) type giterate to commit, pull and push to remote

-> giterate
```

### Config ###
Edit giterate.json
```
{
  "root":"~/Projects"			# Set root directory to find giterated projects
  "log": false					# Enable/disable logging to console
  "state":"I'm on a roll..."	# There will soon be a command to change this...
}
```

### Works how? ###
Finds all subdirectories  with the file `.giterate`. Commits, pulls and pushes each project. You're now git synced.

### Coming soon ###

Set state with command
```
# Set state
giterate state "I'm on a roll..."

# Iterate
giterate
```

