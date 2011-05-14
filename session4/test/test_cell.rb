require 'helper'

class TestCell < MiniTest::Unit::TestCase

  def setup
    @universe = Universe.new
  end 
  
  def test_cell_with_no_neighbours_dies
    @universe = @universe.
      with_cell_at(1,1).
      tick
    refute @universe.has_cell_at?(1,1)
  end 

  def test_cell_with_two_neighbours_lives
    @universe = @universe.
      with_cell_at(1,1).
      with_cell_at(1,2).
      with_cell_at(0,1).
      tick
    assert @universe.has_cell_at?(1,1)
  end 

  def test_cell_with_four_neighbours_dies
    @universe = @universe.
      with_cell_at(1,1).
      with_cell_at(0,1).
      with_cell_at(0,2).
      with_cell_at(0,3).
      with_cell_at(1,2).
      tick
    refute @universe.has_cell_at?(1,1)
  end
  
end
