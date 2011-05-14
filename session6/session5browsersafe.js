(function() {
  var Amir, God;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  window.assert = {
    ok: function() {},
    notOk: function() {},
    deepEqual: function() {},
    equal: function() {}
  };
  Amir = (function() {
    function Amir() {}
    return Amir;
  })();
  God = (function() {
    __extends(God, Amir);
    function God(grid) {
      this.grid = grid != null ? grid : {};
    }
    God.prototype.key = function(x, y) {
      return "" + x + "," + y;
    };
    God.prototype.unkey = function(key) {
      return _(key.split(',')).map(function(s) {
        return +s;
      });
    };
    God.prototype.isAlive = function(x, y) {
      return this.grid[this.key(x, y)] || false;
    };
    God.prototype.breatheLife = function(x, y) {
      return this.grid[this.key(x, y)] = true;
    };
    God.prototype.extinguishLife = function(x, y) {
      return delete this.grid[this.key(x, y)];
    };
    God.prototype.neighbourCount = function(x, y) {
      return _([this.grid[this.key(x + 1, y + 1)], this.grid[this.key(x + 1, y)], this.grid[this.key(x + 1, y - 1)], this.grid[this.key(x, y + 1)], this.grid[this.key(x, y - 1)], this.grid[this.key(x - 1, y + 1)], this.grid[this.key(x - 1, y)], this.grid[this.key(x - 1, y - 1)]]).compact().length;
    };
    God.prototype.evolve = function() {
      var cell, key, newGrid, x, y, _ref, _ref2;
      newGrid = _(this.grid).clone();
      _ref = this.grid;
      for (key in _ref) {
        cell = _ref[key];
        _ref2 = this.unkey(key), x = _ref2[0], y = _ref2[1];
        newGrid[this.key(x + 1, y + 1)] = this.judgement(x + 1, y + 1);
        newGrid[this.key(x + 1, y)] = this.judgement(x + 1, y);
        newGrid[this.key(x + 1, y - 1)] = this.judgement(x + 1, y - 1);
        newGrid[this.key(x, y + 1)] = this.judgement(x, y + 1);
        newGrid[this.key(x, y)] = this.judgement(x, y);
        newGrid[this.key(x, y - 1)] = this.judgement(x, y - 1);
        newGrid[this.key(x - 1, y + 1)] = this.judgement(x - 1, y + 1);
        newGrid[this.key(x - 1, y)] = this.judgement(x - 1, y);
        newGrid[this.key(x - 1, y - 1)] = this.judgement(x - 1, y - 1);
      }
      return this.grid = newGrid;
    };
    God.prototype.render = function() {
      var i, j, _results;
      _results = [];
      for (i = 1; i <= 10; i++) {
        _results.push((function() {
          var _results;
          _results = [];
          for (j = 1; j <= 10; j++) {
            _results.push(this.grid[this.key(i, j)] ? $(".c" + i + "-" + j).addClass('alive') : $(".c" + i + "-" + j).removeClass('alive'));
          }
          return _results;
        }).call(this));
      }
      return _results;
    };
    God.prototype.judgement = function(x, y) {
      if (this.isAlive(x, y)) {
        return _([2, 3]).include(this.neighbourCount(x, y));
      } else {
        return this.neighbourCount(x, y) === 3;
      }
    };
    return God;
  })();
  assert.ok(God);
  God.run = function() {
    var god, tick;
    window.god = god = new God;
    god.breatheLife(8, 5);
    god.breatheLife(8, 6);
    god.breatheLife(8, 7);
    god.breatheLife(-5, 5);
    god.breatheLife(-5, 6);
    god.breatheLife(-5, 7);
    god.breatheLife(-4, 7);
    god.breatheLife(-3, 6);
    tick = function() {
      god.evolve();
      god.render();
      setTimeout(tick, 300);
      return window.grid = god.grid;
    };
    return tick();
  };
  window.God = God;
  $(function() {
    return God.run();
  });
}).call(this);
