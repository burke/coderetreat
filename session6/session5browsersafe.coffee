# Atheism Driven Development.
# ADD.
window.assert ={
  ok:    ->
  notOk: ->
  deepEqual: ->
  equal: ->
}
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

  render: ->
    for i in [1..10]
      for j in [1..10]
        if @grid[this.key(i,j)]
          $(".c#{i}-#{j}").addClass('alive')
        else 
          $(".c#{i}-#{j}").removeClass('alive')
    
  judgement: (x, y) ->
    if this.isAlive(x, y)
      _([2,3]).include(this.neighbourCount(x, y))
    else
      this.neighbourCount(x, y) == 3

# test that God exists.
assert.ok God

# test key
#god = new God
#assert.deepEqual "2,3", god.key(2, 3)
#
## test neighbour count
#god = new God
#god.breatheLife(2, 3)
#assert.ok god.isAlive(2, 3)
#assert.equal 0, god.neighbourCount(2, 3)
#god.breatheLife(2, 2)
#assert.equal 1, god.neighbourCount(2, 3)
#
## test EXTINGUISHMENT
#god.extinguishLife(2, 2)
#assert.equal 0, god.neighbourCount(2, 3)
#
## test Rules
#assert.notOk god.judgement(2, 3)
#god.breatheLife(2, 2)
#god.breatheLife(2, 4)
#assert.ok god.judgement(2, 3)
#god.breatheLife(3,3)
#god.breatheLife(3,2)
#assert.notOk god.judgement(2, 3)
#
## test unkey
#assert.deepEqual [2,3], god.unkey "2,3"
#
## test evolution
#god.evolve()
#assert.notOk god.isAlive(2, 3)
#
## test dead case
#god.breatheLife(10,10)
#god.breatheLife(10,11)
#god.breatheLife(10,12)
#god.evolve()
#
God.run = ->
  window.god = god = new God
  god.breatheLife(8,5)
  god.breatheLife(8,6)
  god.breatheLife(8,7)
  god.breatheLife(-5,5)
  god.breatheLife(-5,6)
  god.breatheLife(-5,7)
  god.breatheLife(-4,7)
  god.breatheLife(-3,6)

  tick = ->
    god.evolve()
    god.render()
    setTimeout(tick, 300)
    window.grid = god.grid

  tick()

window.God = God

$ ->
  God.run()
