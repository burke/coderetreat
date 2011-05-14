require 'helper'

class TestUniverse < MiniTest::Unit::TestCase

  def setup
    @universe = Universe.new
    @cell = Cell.new
  end 
  
  def test_fetch_neighbours_for_cell
    assert_equal 0, @universe.neighbours_for_cell(1, 1)
  end
  
end
