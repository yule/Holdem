class Holdem < Game

  attr_accessor :pot, :current_bet, :board

  #overrides the default number of cards to be 2
  def initialize(h=9, c=2)
    super(h,c)
    @pot = 0
    @current_bet = 0
    @board = []
  end

  def flop
    @current_bet = 0
    3.times { deal_card }
    board
  end  
  
  def turn
    @current_bet = 0
    deal_card
  end  
  
  def river
    @current_bet = 0
    deal_card
  end  
  
  
  private
  def deal_card
    @board << deck.draw
  end
  
end
 
