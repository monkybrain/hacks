# giterate #

rapid, automatic git iterations

### status ###
Works 

### Use ###
```
# Make sure you have installed nodejs and npm

# Install dependencies

  -> npm install

# Add a .giterate file to the root of all project folders you want to include.

  -> touch .giterate

# Set alias (will fix proper bin link later...)

  -> alias giterate="node giterate.js"
  
# Set interval (in minutes)
  
  -> giterate interval 5
  
# Set state (inside single or double quotes"
  
  -> giterate state "I'm on a roll"

# Type 'giterate' to commit, pull and push to remote ONCE...

  -> giterate

# ...or type 'giterate daemon' to commit, pull and push at specified interval

  -> giterate daemon
```

### giterate.json ###

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

