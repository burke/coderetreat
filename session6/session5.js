(function() {
  var Amir, God, assert, god, sys, util, _;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  require('./game_of_life');
  _ = require('./underscore');
  sys = require('sys');
  util = require('util');
  assert = require('assert');
  assert.notOk = function(x) {
    return assert.ok(!x);
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
  god = new God;
  assert.deepEqual("2,3", god.key(2, 3));
  god = new God;
  god.breatheLife(2, 3);
  assert.ok(god.isAlive(2, 3));
  assert.equal(0, god.neighbourCount(2, 3));
  god.breatheLife(2, 2);
  assert.equal(1, god.neighbourCount(2, 3));
  god.extinguishLife(2, 2);
  assert.equal(0, god.neighbourCount(2, 3));
  assert.notOk(god.judgement(2, 3));
  god.breatheLife(2, 2);
  god.breatheLife(2, 4);
  assert.ok(god.judgement(2, 3));
  god.breatheLife(3, 3);
  god.breatheLife(3, 2);
  assert.notOk(god.judgement(2, 3));
  assert.deepEqual([2, 3], god.unkey("2,3"));
  god.evolve();
  assert.notOk(god.isAlive(2, 3));
  god.breatheLife(10, 10);
  god.breatheLife(10, 11);
  god.breatheLife(10, 12);
  god.evolve();
  assert.ok(god.isAlive(11, 11));
  sys.puts("OMG ALL THE TESTS PASSED ITS GREEN HOORAY");
}).call(this);
