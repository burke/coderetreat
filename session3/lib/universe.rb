class Universe

  def initialize
    @grid = {}
  end 

  def get_cell_at(x, y)
    return nil unless @grid[x]
    @grid[x][y]
  end 

  def set_alive_at(x, y)
    @grid[x] ||= {}
    @grid[x][y] = Cell.alive
  end 
  
  def evolve
    @grid.each do |x, hash|
      hash.each do |y, cell|
        cell.tick(number_of_live_neighbours_at(x,y))
      end
    end 
  end

  def number_of_live_neighbours_at(x,y)
    [
      get_cell_at(x + 1, y + 1),
      get_cell_at(x + 1, y),
      get_cell_at(x + 1, y - 1),
      get_cell_at(x, y + 1),
      get_cell_at(x, y - 1),
      get_cell_at(x - 1, y + 1),
      get_cell_at(x - 1, y),
      get_cell_at(x - 1, y - 1)
    ].count { |cell| cell && cell.alive? }
  end 
  
end 
