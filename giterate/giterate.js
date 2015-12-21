// Generated by CoffeeScript 1.10.0
(function() {
  var Magic, Parser, colors, config, error, exec, h, log;

  exec = require("child_process").exec;

  colors = require("colors");

  config = {
    root: "~/Projects"
  };

  log = function(output) {
    return console.log(output.toString().green);
  };

  error = function(error) {
    return console.error(error.toString().red);
  };

  h = "got here";

  Magic = (function() {
    function Magic() {}

    Magic.spells = {
      cd: function(dir) {
        return "cd " + dir;
      },
      find: "find " + config.root + " -name .giterate -prune",
      test: "ls -la",
      git: {
        add: "git add .",
        commit: function(message) {
          return "git commit -a -m \"" + message + "\"";
        },
        push: "git push -u --all",
        pull: "git pull --all",
        status: "git status"
      }
    };

    Magic.combine = function(array) {
      return array.join(" && ");
    };

    Magic.cast = function(spell, callback) {
      return exec(spell, callback);
    };

    Magic.perform = function(ritual, callback) {
      return this.cast(ritual, callback);
    };

    return Magic;

  })();

  Parser = (function() {
    function Parser() {}

    Parser.processPaths = function(stdout) {
      var paths;
      paths = stdout.split("\n");
      return paths.map(function(path) {
        return path = path.slice(0, path.lastIndexOf("/"));
      });
    };

    return Parser;

  })();

  Magic.cast(Magic.spells.find, function(err, stdout, stderr) {
    var i, len, path, paths, results, ritual;
    paths = Parser.processPaths(stdout);
    results = [];
    for (i = 0, len = paths.length; i < len; i++) {
      path = paths[i];
      ritual = Magic.combine([Magic.spells.cd(path), Magic.spells.git.add, Magic.spells.git.commit("Still hacking away at giterate"), Magic.spells.git.pull, Magic.spells.git.push]);
      log(ritual);
      results.push(Magic.perform(ritual, function(err, stdout, stderr) {
        return log(stdout);
      }));
    }
    return results;
  });

}).call(this);
