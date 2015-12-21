# giterate #

rapid, automatic git iterations

### Use ###
1) Add `.giterate` file to the root of your project folder.
2) type `giterate` to commit, pull and push to remote

### Works how? ###
Finds all subdirectories in home with the file `.giterate`. Commits, pulls and pushes each project. You're now git synced.

### CLI ###

Run:

`giterate`

Set status (commit message)

`giterate state <message>`

Example:
```
# Set state
giterate state "I'm on a roll..."

# Iterate
giterate

