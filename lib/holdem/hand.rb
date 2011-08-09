

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
    get_matching_hash[:trips] && get_matching_hash[:pairs]
  end
  
  def is_flush?
    just_suits.sort.each{|n|
      return true if just_suits.count(n) >= 5
    }
    false
  end
  
  def is_straight?
    vals = just_vals.uniq.sort
    vals.unshift(1) if vals.include?(14)
    vals.each_with_index{|n,m|    
       return n if (n..(n+4)).to_a === just_vals.uniq.sort[m..(m+4)]
    }
    return false
  end
  
  def is_three_of_a_kind?
    !!get_matching_hash[:trips] 
  end
  
  def is_two_pair?
    get_matching_hash[:pairs].size>1
  end  
  
  def is_one_pair?
    !!get_matching_hash[:pairs]
  end
  
  
  private

 
  def get_matching_hash(revers=false)
    results = {:pairs=>[], :trips=>[], :quads=>[], :high_cards=>[]}
    just_vals.sort.each{|n|
      c = just_vals.count(n)
      case c
        when 1  
          results[:high_cards] << n
        when 2 
          results[:pairs] << n
        when 3 
          results[:trips] << n
        when 4 
          results[:quads] << n
      end

    }
    results[:high_cards] << results[:pairs].min if results[:pairs].size > 2 #low pair of three pair is a high card
    results[:pairs] << results[:trips].min if results[:trips].size > 1 # low trips of hand is pair
    results
  end  
  
  
end
