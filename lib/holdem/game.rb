


class Holdem < Deck::Game


  #overrides the default number of cards to be 2
  def initialize(h=9, c=2)
    super(h,c)
    @@pot = 0
    @@current_bet = 0
  end


  def self.pot=(amt)
    @@pot = amt
  end

  def self.pot
    @@pot
  end

  def self.current_bet=(amt)
    @@current_bet = amt
  end

  def self.current_bet
    @@current_bet
  end
  	

end
 
