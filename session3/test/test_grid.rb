require 'helper'
require 'cell'
require 'universe'


class TestGrid < MiniTest::Unit::TestCase

  def setup
    @universe = Universe.new
  end 
  
  def test_alive_cell_is_still_alive_with_2_neighbours
    @universe.set_alive_at(2,2)
    @universe.set_alive_at(1,1)
    @universe.set_alive_at(1,2)
    @universe.evolve
    assert @universe.get_cell_at(2,2).alive?
  end

  def test_cell_dies_with_less_than_two_neighbours
    @universe.set_alive_at(0,0)
    cell = @universe.get_cell_at(0,0)
    @universe.evolve
    refute cell.alive?
  end 

  def test_universe_is_snapshotted_for_evolution
    #   1 2 3
    # 1 - - -
    # 2 - O -
    # 3 - - - 
    skip
    @universe.set_alive_at(1,1)
    @universe.set_alive_at(1,2)
    @universe.set_alive_at(1,3)
    @universe.set_alive_at(3,2)
    @universe.set_alive_at(2,2)
    @universe.evolve
    assert_equal 4, @universe.number_of_live_neighbours_at(2,2)
    refute @universe.get_cell_at(2,2).alive?
  end

end
