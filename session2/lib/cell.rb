class Cell
  attr_accessor :state
  def initialize
    @state = true
  end
  
  def alive!
    self.state = true
  end
  
  def dead!
    self.state = false
  end
  
  def alive?
    state
  end
  
  def dead?
    !state
  end
end