
class Player

  attr_reader :stack

  def initialize(stck = 100000)
    @stack = stck
  end


  def bet(amt)
    amt = stack if amt>stack
    @stack -= amt
    @pot = @pot || 0
    @pot += amt 
    @current_bet = amt 
  end


  def call
   bet(@current_bet) 
  end

end

