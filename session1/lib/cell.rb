require 'ruby-debug'

class Cell

  attr_accessor :state
  attr_accessor :neighbour_count
  
  def initialize(state)
    @state = state
    @neighbour_count = 3
  end 

  def next_generation
    if self.state
      self.state = case neighbour_count
                   when 0..1 then false
                   when 2..3 then true
                   when 4..8 then false
                   end 
    else
      # cell is currently dead
      self.state = (neighbour_count == 3)
    end 
  end 
  
  
end 
