require 'helper'

class TestCell < MiniTest::Unit::TestCase
  def setup
    @cell = Cell.new
  end
  
  def test_life
    @cell.alive!
    assert_equal true, @cell.alive?
    assert_equal false, @cell.dead?
    
    @cell.dead!
    assert_equal false, @cell.alive?
    assert_equal true, @cell.dead?
  end
  
  def test_alive_neighbours
    #  2,3 ==> 1,3; 3,3
    
    # assert_instance_of Hash, @grid.grid
  end

end