
class Player

  attr_accessor :game, :table, :amount_in_pot, :total_amount_in_pot, :stack

  def initialize(stck = 100000, tbl = Table.new)
    @stack = stck
    @table = tbl
    @table.players << self unless (@table.players.include?(self))
  end

  def bet(amt)
    return if amt.nil? or (amt+amount_in_pot) < @table.current_game.current_bet
    amt = @stack if amt>@stack
    @stack -= amt
    @table.current_game.pot += amt
    @table.current_game.current_bet = [amt,@table.current_game.current_bet].max
    @amount_in_pot = amt
  end



  def call
    bet(@table.current_game.current_bet - amount_in_pot) 
  end

  def amount_in_pot
    @amount_in_pot||0
  end  

  def raise_by(amt)
    bet(amt+@table.current_game.current_bet)
  end
  
  def raise_to(amt)
    bet(amt)
  end
  
  def check
  end


  def fold  
    @table.current_game.hands.delete_if{|n| n.player == self}
  end


end

