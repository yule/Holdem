class Holdem < Game

  attr_accessor :pot, :current_bet, :board, :table, :players

  #overrides the default number of cards to be 2, takes an extra parameter as must belong to table
  def initialize(t, c=2)
    super(t.players.size, c)
    @pot = 0
    @current_bet = 0
    @board = []
    @table = t
  end

  def deal
    reset_bets
    super
    (0..@hands.size-1).each{|n| 
      @hands[n].player = @table.players[n] 
      @hands[n].game = self
    }
    self
  end  

  def flop
    @current_bet = 0
    3.times { deal_card }
    accumulate_bets
    board
  end  
  
  def turn
    @current_bet = 0
    accumulate_bets
    deal_card
  end  
  
  def river
    @current_bet = 0
    accumulate_bets
    deal_card
  end  
  
  
  private
  def deal_card
    @board << deck.draw
  end
  
  def accumulate_bets
    @table.players.map{|p| 
      p.total_amount_in_pot += p.amount_in_pot
      p.amount_in_pot = 0
    }    
  end
  
  def reset_bets
    @table.players.map{|p| 
      p.total_amount_in_pot = 0
      p.amount_in_pot = 0
    }
  end
  
end
 
