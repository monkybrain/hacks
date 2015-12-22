// Generated by CoffeeScript 1.10.0
(function() {
  var Light, Noun, Room, Universe,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  Universe = (function() {
    Universe.self = 'universe';

    Universe.Self = 'Universe';

    function Universe() {
      this.contains = [];
      this.scope = null;
    }

    Universe.prototype.add = function(object) {
      this.contains.push(object);
      return this.scope = this.contains[this.contains.length - 1];
    };

    return Universe;

  })();


  /* ABSTACTS: NOUN */

  Noun = (function(superClass) {
    extend(Noun, superClass);

    Noun.count = 0;

    Noun.scope = null;

    Noun.prototype.ref = null;

    Noun.prototype.add = function(object) {
      return this.contains.push(object);
    };

    function Noun(property) {
      this.index++;
      this.property = property;
      this.contains = [];
    }

    Noun.prototype.set = function(property, value) {};

    Noun.prototype.get = function(property, value) {};

    Noun.prototype.containedIn = [];

    Noun.prototype.state = {};

    Noun.prototype.property = {};

    return Noun;

  })(Universe);


  /* CONCRETES: ROOM, LIGHT */

  Light = (function(superClass) {
    extend(Light, superClass);

    Light.self = 'light';

    Light.Self = 'Light';

    Light.lexical = {
      word: 'light',
      article: {
        def: 'the',
        indef: 'a'
      }
    };

    function Light(ref) {
      var property;
      this.ref = ref;
      this.index = Light.count++;
      Noun.count++;
      property = {
        'on': false,
        'brightness': 45,
        'color': 'blue'
      };
      Light.__super__.constructor.call(this, property);
    }

    return Light;

  })(Noun);

  Room = (function(superClass) {
    extend(Room, superClass);

    Room.self = 'room';

    Room.Self = 'Room';

    Room.lexical = {
      word: 'room',
      article: {
        def: 'the',
        indef: 'a'
      }
    };

    function Room(ref) {
      var property;
      this.ref = ref;
      Noun.scope = this;
      this.index = Room.count++;
      Noun.count++;
      property = {
        'size': 20,
        'windows': 2
      };
      Room.__super__.constructor.call(this, property);
    }

    return Room;

  })(Noun);

  module.exports = {
    abstracts: {
      Universe: Universe,
      Noun: Noun
    },
    concretes: [Room, Light]
  };

}).call(this);