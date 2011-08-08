

class Hand < Deck
  
  attr_accessor :player
  
  def is_royal_flush?
    true
  end
  
  def is_straight_flush?
    true
  end
  
  def is_four_of_a_kind?
    true
  end
  
  def is_full_house?
    true
  end
  
  def is_flush?
    true
  end
  
  def is_straight?
    true
  end
  
  def is_three_of_a_kind?
    true
  end
  
  def is_two_pair?
    true
  end  
  
  def is_one_pair?
    true
  end
  
  
end
