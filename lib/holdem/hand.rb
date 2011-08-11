

class Hand 
  
  include Enumerable
  include Comparable
  
  attr_accessor :player, :game
  
  def full_hand
    (@game.board + @cards).sort
  end  

  def each 
    self
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
  
  def <=>(other)
    same = rank <=> other.rank
    return same unless same==0
    kickers = 5
    case rank.to_i
      when 5, 9..10 # straight or straight flush
          return is_straight? <=> other.is_straight?
      when 8 # quads
          same_quads = get_matching_hash[:quads].max <=> other.get_matching_hash[:quads].max
          return same_quads unless same_quads == 0
          kickers = 1
      when 7 # full house
          same_trips = get_matching_hash[:trips].max <=> other.get_matching_hash[:trips].max
          return same_trips unless same_trips == 0
          return get_matching_hash[:pairs].max <=> other.get_matching_hash[:pairs].max
      when 6 # flush TODO
          return get_matching_hash[:high_cards].max <=> other.get_matching_hash[:high_cards]      
      when 4 # trips
          same_trips = get_matching_hash[:trips].max <=> other.get_matching_hash[:trips].max
          return same_trips unless same_trips == 0
          kickers = 2
      when 3 # two pair
          this_pairs =  get_matching_hash[:pairs].uniq.sort
          other_pairs = other.get_matching_hash[:pairs].uniq.sort
          same_top = this_pairs[this_pairs.length-1] <=> other_pairs[other_pairs.length-1]
          return same_top unless same_top == 0
          same_second = this_pairs[this_pairs.length-2] <=> other_pairs[other_pairs.length-2]
          return same_second unless same_second == 0
          kickers = 1
      when 2 # pair
          same_pair = get_matching_hash[:pairs].max <=> other.get_matching_hash[:pairs].max
          return same_pair unless same_pair == 0
          kickers = 3
    end
    (1..kickers).to_a.each{|n|
      this_kickers = get_matching_hash[:high_cards].uniq.sort.reverse
      other_kickers = other.get_matching_hash[:high_cards].uniq.sort.reverse
      check = this_kickers[n-1] <=> other_kickers[n-1]      
      return check unless check == 0
    }
    return 0
  end

  def rank
     possible = %w(royal_flush straight_flush four_of_a_kind full_house flush straight three_of_a_kind two_pair one_pair high_card)
     possible.each_with_index{|c,n|
      return  possible.length - n if send "is_#{c}?"
     }
     1
  end
  
  def is_royal_flush?
    is_straight? == 14 && is_straight_flush?
  end
  
  def is_straight_flush?
    cons = {:hearts=>0, :diamonds=>0, :clubs=>0, :spades=>0}
    full_hand.each_with_index{|hand,i|
      next_card = Card.new(hand.to_i + 1, hand.suit)
      cons[hand.suit.downcase.to_sym] += 1 if full_hand.include?(next_card)
    }
    cons[:hearts]==4 || cons[:diamonds]==4 || cons[:clubs]==4 || cons[:spades]==4
  end
  
  def is_four_of_a_kind?
    !get_matching_hash[:quads].empty?
  end
  
  def is_full_house?
    (!get_matching_hash[:trips].empty? && !get_matching_hash[:pairs].empty?)
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
       return n+4 if (n..(n+4)).to_a === vals[m..(m+4)]
    }
    false
  end
  
  def is_three_of_a_kind?
    !get_matching_hash[:trips].empty? 
  end
  
  def is_two_pair?
    get_matching_hash[:pairs].uniq.size>1
  end  
  
  def is_one_pair?
    !get_matching_hash[:pairs].empty?
  end
  
  def is_high_card?
    true
  end  
  

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
    results[:pairs] = results[:pairs].uniq
    results[:trips] = results[:trips].uniq
    results[:high_cards] << results[:pairs].min if results[:pairs].size > 2 #low pair of three pair is a high card
    results[:pairs] << results[:trips].min if results[:trips].size > 1
    results
  end  
  
  
end
