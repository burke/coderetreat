require 'helper'

class TestGrid < MiniTest::Unit::TestCase
  def setup
    @grid = Grid.new
  end
  
  def test_grid_has_default_hash
    assert_instance_of Hash, @grid.grid
  end
  
  def test_alive_neighbours
    #   1 2 3
    # 2 - - -
    # 3 - O -
    # 4 - - -
    assert_equal 0, @grid.alive_neighbours_for(2,3)
    @grid.set_alive_at(1,2)
    assert_equal 1, @grid.alive_neighbours_for(2,3)
    @grid.set_alive_at(3,4)
    assert_equal 2, @grid.alive_neighbours_for(2,3)
  end

  def test_set_alive_at_x_and_y
    @grid.set_alive_at(3,2)
    assert_equal true, @grid.get_cell_at(3, 2).alive?
  end
  
  def test_get_cell_setting
    @grid.set_cell_at(3, 2, true)
    assert_instance_of Cell, @grid.get_cell_at(3, 2)
  end
  
end
