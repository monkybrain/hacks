# giterate #

rapid, automatic git iterations

### status ###
Works 

### Use ###
```
# 1) Make sure you have installed nodejs and npm

# 2) Install dependencies

  -> npm install

# 3) Add a .giterate file to the root of all project folders you want to include.

  -> touch .giterate

# 4) Set alias (will fix proper bin link later...)

  -> alias giterate="node giterate.js"

# 5) type 'giterate' to commit, pull and push to remote ONCE

  -> giterate

# 6) type 'giterate daemon' to commit, pull and push at interval specified in giterate.json

  -> giterate daemon
```

### Config ###
Edit giterate.json
```
{
  "interval": 1,                # Interval between giterations in minutes
  "root":"~/Projects",			# Set root directory to find giterated projects
  "log": true,					# Enable/disable logging to console
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

