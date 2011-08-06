
class Player

  attr_reader :stack, :amount_in_pot

  def initialize(stck = 100000)
    @stack = stck
  end

  def bet(amt)
    return if amt.nil? or (amt+amount_in_pot) < Holdem.current_bet
    amt = @stack if amt>@stack
    @stack -= amt
    Holdem.pot += amt
    Holdem.current_bet = [amt,Holdem.current_bet].max
    @amount_in_pot = amt
  end


  def call
    bet(Holdem.current_bet - amount_in_pot) 
  end

  def amount_in_pot
    @amount_in_pot||0
  end  

  def raise_by(amt)
    bet(amt+Holdem.current_bet)
  end
  
  def raise_to(amt)
    bet(amt)
  end
  
  def fold
  end  

end

