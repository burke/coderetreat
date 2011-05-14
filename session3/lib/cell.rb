class Cell

  attr_reader :alive
  
  def initialize
    @alive = true
  end 
  
  def self.alive
    Cell.new
  end 

  def alive?
    self.alive
  end 

  def tick(num_neighbours)
    @alive = case num_neighbours
             when 0..1 then false
             when 2..3 then true
             when 4..8 then false
             end 
  end 
  
end 


