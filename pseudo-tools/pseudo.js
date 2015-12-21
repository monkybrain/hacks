// Generated by CoffeeScript 1.10.0
(function() {
  var args, argv, cast, colors, command, commands, error, exec, log, message, messageIndex, modifier, shell, spell;

  argv = require("yargs").argv;

  shell = require("shelljs/global");

  colors = require("colors");

  exec = require("child_process").exec;

  log = function(output) {
    return console.log(output);
  };

  error = function(error) {
    return console.error(("" + error).red);
  };

  cast = function(spell, callback) {
    return exec(spell, callback);
  };

  spell = function(commands) {
    return commands.join(" && ");
  };


  /* COMMANDS */

  commands = {

    /* COMMIT */
    commit: function(modifier) {
      var find;
      if (!which("git")) {
        return error("Error: git not installed");
      } else {
        find = ["find ~ -name .git -type d -prune"];
        return cast(spell(find), function(err, stdout, stderr) {
          var dirs, i, index, kermit, len, path, paths, results;
          paths = stdout.trim().split("\n").map(function(path) {
            return path.slice(0, path.lastIndexOf("/"));
          });
          dirs = paths.map(function(path) {
            var dir;
            dir = path.slice(path.lastIndexOf("/"));
            return dir.slice(1);
          });
          if (modifier != null) {
            modifier === 'here';
            paths = ["."];
          }
          index = 0;
          results = [];
          for (i = 0, len = paths.length; i < len; i++) {
            path = paths[i];
            kermit = ["cd " + path, "git add .", "git commit -m \"" + message + "\"", "git push -u --all"];
            results.push(cast(spell(kermit), function(err, stdout, stderr) {
              if (stderr !== '') {
                return error(dirs[index++] + ": " + stderr);
              } else {
                return log(dirs[index++] + ": ok");
              }
            }));
          }
          return results;
        });
      }
    }
  };

  if (argv._[0] != null) {
    modifier = null;
    args = argv._;
    command = args[0];
    messageIndex = 1;
    if (args[1] != null) {
      modifier = args[1];
      if (modifier === 'all') {
        messageIndex = 2;
      }
      if (modifier === 'here') {
        messageIndex = 2;
      }
    }
    message = args[1] ? args[1] : 'pseudo-tools: testing standard message';
    console.log(command);
  }

  if (command === 'commit') {
    commands.commit(modifier);
  }

}).call(this);