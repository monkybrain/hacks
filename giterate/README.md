# giterate #

rapid, automatic git iterations

### status ###
Works 

### Use ###
```

# 1) Make sure you have installed nodejs and npm

# 2) Install dependencies by typein 'npm install' in root folder
-> npm install 

# 3) Set alias (will fix proper bin link later...)

-> alias giterate="node giterate.js"

# 2) Add a .giterate file to the root of your project folder.

-> touch .giterate

# 3) type 'giterate' to commit, pull and push to remote ONCE

-> giterate

# 4) type 'giterate daemon' to commit, pull and push at interval specified in giterate.json

-> giterate daemon
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

