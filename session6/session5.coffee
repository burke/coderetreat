require './game_of_life'
_ = require './underscore'

sys = require 'sys'
util = require 'util'
assert = require 'assert'

assert.notOk = (x) -> assert.ok ! x

# Atheism Driven Development.
# ADD.

class Amir

class God extends Amir
  constructor: (@grid = {}) -> # a digital frontier

  key: (x, y) -> "#{x},#{y}"

  unkey: (key) -> _(key.split(',')).map (s) -> (+s)

  isAlive: (x, y) ->
    @grid[this.key(x, y)] or false

  breatheLife: (x, y) ->
    @grid[this.key(x, y)] = true

  extinguishLife: (x, y) ->
    delete @grid[this.key(x, y)]

  neighbourCount: (x, y) ->
    _([
      @grid[this.key(x + 1, y + 1 )],
      @grid[this.key(x + 1, y     )],
      @grid[this.key(x + 1, y - 1 )],
      @grid[this.key(x, y + 1     )],
      @grid[this.key(x, y - 1     )],
      @grid[this.key(x - 1, y + 1 )],
      @grid[this.key(x - 1, y     )],
      @grid[this.key(x - 1, y - 1 )]
    ]).compact().length

  evolve: ->
    newGrid = _(@grid).clone()
    for key, cell of @grid
      [x, y] = this.unkey(key)
      newGrid[this.key(x + 1, y + 1)] = this.judgement(x + 1, y + 1)
      newGrid[this.key(x + 1, y    )] = this.judgement(x + 1, y    )
      newGrid[this.key(x + 1, y - 1)] = this.judgement(x + 1, y - 1)
      newGrid[this.key(x,     y + 1)] = this.judgement(x,     y + 1)
      newGrid[this.key(x,     y    )] = this.judgement(x,     y    )
      newGrid[this.key(x,     y - 1)] = this.judgement(x,     y - 1)
      newGrid[this.key(x - 1, y + 1)] = this.judgement(x - 1, y + 1)
      newGrid[this.key(x - 1, y    )] = this.judgement(x - 1, y    )
      newGrid[this.key(x - 1, y - 1)] = this.judgement(x - 1, y - 1)
    @grid = newGrid

  judgement: (x, y) ->
    if this.isAlive(x, y)
      _([2,3]).include(this.neighbourCount(x, y))
    else
      this.neighbourCount(x, y) == 3

# test that God exists.
assert.ok God

# test key
god = new God
assert.deepEqual "2,3", god.key(2, 3)

# test neighbour count
god = new God
god.breatheLife(2, 3)
assert.ok god.isAlive(2, 3)
assert.equal 0, god.neighbourCount(2, 3)
god.breatheLife(2, 2)
assert.equal 1, god.neighbourCount(2, 3)

# test EXTINGUISHMENT
god.extinguishLife(2, 2)
assert.equal 0, god.neighbourCount(2, 3)

# test Rules
assert.notOk god.judgement(2, 3)
god.breatheLife(2, 2)
god.breatheLife(2, 4)
assert.ok god.judgement(2, 3)
god.breatheLife(3,3)
god.breatheLife(3,2)
assert.notOk god.judgement(2, 3)

# test unkey
assert.deepEqual [2,3], god.unkey "2,3"

# test evolution
god.evolve()
assert.notOk god.isAlive(2, 3)

# test dead case
god.breatheLife(10,10)
god.breatheLife(10,11)
god.breatheLife(10,12)
god.evolve()
assert.ok god.isAlive(11,11)

sys.puts "OMG ALL THE TESTS PASSED ITS GREEN HOORAY"
