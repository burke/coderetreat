require File.expand_path('../helper', __FILE__)
require 'cell'

describe Cell do
  
  it 'takes a state as an initialization parameter' do
    Cell.new(true)
  end 

  before do
    @cell = Cell.new(true)
  end 
  
  it 'has a state' do
    @cell.state.must_equal true
  end 

  it 'knows its neighbour count' do
    @cell.neighbour_count.must_equal 3
  end 
  
  it 'dies if it has less than two neighbours' do
    @cell.neighbour_count = 1
    @cell.state = true
    @cell.next_generation
    @cell.state.must_equal false
  end 

  it 'lives if it has two to three neighbours' do
    @cell.neighbour_count = 2
    @cell.state = true
    @cell.next_generation
    @cell.state.must_equal true
  end 

  it 'dies if it has more than three neighbours' do
    @cell.neighbour_count = 4
    @cell.state = true
    @cell.next_generation
    @cell.state.must_equal false
  end 

  it 'becomes alive if it has exactly three neighbours' do
    @cell.neighbour_count = 3
    @cell.state = false
    @cell.next_generation
    @cell.state.must_equal true
  end 

  it 'does not become alive if it does not have three neighbours' do
    @cell.neighbour_count = 2
    @cell.state = false
    @cell.next_generation
    @cell.state.must_equal false
  end 
  
end 
