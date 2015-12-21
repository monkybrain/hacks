// Generated by CoffeeScript 1.10.0
(function() {
  var Flow, Magic, Parser, Promise, args, colors, config, error, exec, fs, interval, log, marker, min2ms;

  exec = require("child_process").exec;

  args = require("yargs").argv._;

  colors = require("colors");

  fs = require("fs");

  Promise = require("promise");

  config = {};

  interval = null;

  log = function(output) {
    if (config.log) {
      return console.log(output.toString().green);
    }
  };

  error = function(error) {
    if (config.log) {
      return console.error(error.toString().red);
    }
  };

  marker = function() {
    return log("got here");
  };

  min2ms = function(min) {
    return min * 60 * 1000;
  };


  /* MAGIC */

  Magic = (function() {
    function Magic() {}

    Magic.spells = {
      cd: function(dir) {
        return "cd " + dir;
      },
      find: function(root) {
        return "find " + root + " -name .giterate -prune";
      },
      list: "ls -la",
      git: {
        add: "git add .",
        commit: function(message) {
          return "git commit -a -m \"" + message + "\"";
        },
        push: "git push -u --all",
        pull: "git pull --all",
        status: "git status"
      },
      timerTest: "while true; do echo 'test'; sleep 5; done"
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


  /* PARSER */

  Parser = (function() {
    function Parser() {}

    Parser.commands = function(args) {
      if (args.length === 0) {
        return 'run';
      }
      if (args[0] != null) {
        if (args[0] === 'daemon') {
          return 'daemon';
        }
        if (args[0] === 'state') {
          return 'state';
        }
      }
    };

    Parser.paths = function(stdout) {
      var paths;
      paths = stdout.trim().split("\n");
      return paths.map(function(path) {
        return path = path.slice(0, path.lastIndexOf("/"));
      });
    };

    return Parser;

  })();


  /* Flow */

  Flow = (function() {
    function Flow() {}

    Flow.init = function() {
      return new Promise(function(resolve, reject) {
        var data, err, error1;
        try {
          data = fs.readFileSync('giterate.json', 'utf8');
        } catch (error1) {
          err = error1;
          error("Cannot open giterate.json");
          reject();
        }
        config = JSON.parse(data);
        this.command = Parser.commands(args);
        return resolve();
      });
    };

    Flow.runOnce = function() {
      return Magic.cast(Magic.spells.find(config.root), function(err, stdout, stderr) {
        var i, len, path, paths, results, ritual;
        paths = Parser.paths(stdout);
        results = [];
        for (i = 0, len = paths.length; i < len; i++) {
          path = paths[i];
          ritual = Magic.combine([Magic.spells.cd(path), Magic.spells.git.add, Magic.spells.git.commit(config.state), Magic.spells.git.pull, Magic.spells.git.push]);
          results.push(Magic.perform(ritual, function(err, stdout, stderr) {
            return log("daemon: giterated at " + Date());
          }));
        }
        return results;
      });
    };

    Flow.daemon = function() {
      log("\ndaemon: You summoned me?");
      log("\n(Use ctrl-c to dismiss him)\n");
      Flow.runOnce();
      return interval = setInterval(function() {
        return Flow.runOnce();
      }, min2ms(config.interval));
    };

    Flow.state = function() {
      var state;
      log("state");
      state = args[1];
      return log(state);
    };

    return Flow;

  })();

  Flow.init().then(function() {
    if (this.command === 'run') {
      Flow.runOnce();
    }
    if (this.command === 'daemon') {
      Flow.daemon();
    }
    if (this.command === 'state') {
      return Flow.state();
    }
  }, function() {
    return error("Aborted...");
  });

  process.on('SIGINT', function() {
    interval = null;
    log("\ndaemon: I'l be back...\n");
    return process.exit();
  });

}).call(this);
