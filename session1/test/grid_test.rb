require File.expand_path('../helper', __FILE__)
require 'grid'
require 'cell'

describe Grid do

  before do
    @grid = Grid.new
  end 

  it 'can return the cell at a given grid position' do
    @grid.cell_at(0,0).must_be_instance_of Cell
  end 

  it 'should return a dead cell if accessed outside of existing cells' do
    @grid.cell_at(100,349193).state.must_equal false
  end 

  it 'accepts a list of initially alive cells' do
    $DEBUG = 1
    grid = Grid.new([0,0],[0,1])
    grid.cell_at(0,0).state.must_equal true
    grid.cell_at(0,1).state.must_equal true
    grid.cell_at(1,1).state.must_equal false
  end 
  
end 

