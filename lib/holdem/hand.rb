

class Hand 
  
  attr_accessor :player, :game
  
  def full_hand
    (@game.board + @cards).sort
  end  
  
  def just_vals
    full_hand.map{|h|h.to_i}
  end  
  
  def just_suits
    full_hand.map{|h|h.suit}
  end
  
  def to_s
    @cards.inspect
  end
  
  def is_royal_flush?
    true
  end
  
  def is_straight_flush?
    true
  end
  
  def is_four_of_a_kind?
    !!get_matching_hash[:quads]
  end
  
  def is_full_house?
    get_matching_hash[:trips] && get_matching_hash[:pair]
  end
  
  def is_flush?
    just_suits.sort.each{|n|
      return true if just_suits.count(n) == 5
    }
    false
  end
  
  def is_straight?
    true
  end
  
  def is_three_of_a_kind?
    !!get_matching_hash[:trips] 
  end
  
  def is_two_pair?
    first_pair = get_matching_hash[:pair]
    second_pair = get_matching_hash(true)[:pair]
    first_pair && second_pair && (first_pair != second_pair)
  end  
  
  def is_one_pair?
    !!get_matching_hash[:pair]
  end
  
  
  private
  
  def get_matching_hash(revers=false)
    quads = trips = pair = high_card = false
    vals = just_vals.sort
    vals = vals.reverse if revers
    vals.each{|n|
      quads = n if just_vals.count(n) == 4
      trips = n if just_vals.count(n) == 3
      pair = n if just_vals.count(n) == 2
      high_card = n if just_vals.count(n) == 1
    }
    {:quads=>quads, :trips=>trips, :pair=>pair, :high_card=>high_card}
  end  
  
  
end
