class Grid
  def initialize
    @grid = {}
  end
  
  def grid
    @grid
  end
  
  def alive_neighbours_for(x, y)
    neighbours = [
      get_cell_at(x+1, y+1),
      get_cell_at(x+1, y),
      get_cell_at(x+1, y-1),
      get_cell_at(x, y+1),
      get_cell_at(x, y-1),
      get_cell_at(x-1, y+1),
      get_cell_at(x-1, y),
      get_cell_at(x-1, y-1)
    ]
    
    alive = neighbours.count { |neighbour| neighbour && neighbour.alive? }
    
  end

  def get_cell_at(x,y)
    @grid[x] ||= {}
    @grid[x][y]
  end
    
  def set_cell_at(x,y,state)
    @grid[x] ||= {}
    @grid[x][y] = Cell.new
    @grid[x][y].state = state
  end
    
  def set_alive_at(x, y)
    set_cell_at(x,y,true)
  end
end