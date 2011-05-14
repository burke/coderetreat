require 'rubygems'
require 'active_support/all'

class Universe

  def initialize(initial_grid = {})
    @grid = initial_grid
  end 

  def get_cell(x, y)
    return nil unless @grid[x] 
    @grid[x][y]
  end

  def has_cell_at?(x, y)
    @grid[x] && @grid[x][y]
  end

  def tick
    Universe.new.tap do |u|
      @grid.each do |x, hash|
        @grid.each do |y, cell|
          if cell_should_live(self.neighbours_for_cell(x,y))
            u = u.with_cell_at(x, y)
          end
        end
      end
    end 
  end

  def cell_should_live(num_neighbours)
    (2..3).include?(num_neighbours)
  end 
  
  def with_cell_at(x, y)
    Universe.new(@grid.deep_merge({x => {y => Cell.new}}))
  end 
  
  def neighbours_for_cell(x, y)
    [
      get_cell(x + 1, y + 1 ), 
      get_cell(x + 1, y     ), 
      get_cell(x + 1, y - 1 ), 
      get_cell(x,     y + 1 ), 
      get_cell(x,     y - 1 ), 
      get_cell(x - 1, y + 1 ), 
      get_cell(x - 1, y     ), 
      get_cell(x - 1, y - 1 )
    ].compact.count
  end 

end 
