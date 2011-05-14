require 'ruby-debug'

class Grid

  attr_reader :width, :height
  
  def initialize(*initial_cells)
    @grid = Hash.new { Hash.new { Cell.new(false) } }
    initial_cells.each do |x, y|
      @grid[x][y] = Cell.new(true)
      debugger if $DEBUG
    end
    puts 
  end

  def cell_at(x, y)
    @grid[x][y]
  end 
  
end 
