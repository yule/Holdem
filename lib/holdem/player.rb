
class Player

  attr_reader :stack, :amount_in_pot
  attr_accessor :game

  def initialize(stck = 100000, gm = Holdem.new)
    @stack = stck
    @game = gm
  end

  def bet(amt)
    return if amt.nil? or (amt+amount_in_pot) < @game.current_bet
    amt = @stack if amt>@stack
    @stack -= amt
    @game.pot += amt
    @game.current_bet = [amt,@game.current_bet].max
    @amount_in_pot = amt
  end


  def call
    bet(@game.current_bet - amount_in_pot) 
  end

  def amount_in_pot
    @amount_in_pot||0
  end  

  def raise_by(amt)
    bet(amt+@game.current_bet)
  end
  
  def raise_to(amt)
    bet(amt)
  end
  
  def fold
  end  

end

