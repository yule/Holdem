require '../lib/holdem.rb'


@table = Table.new
10.times do 
  Player.new(10000, @table)
end

@table.new_hand(true)
@table.new_hand

@table.current_hand.flop
@table.current_hand.turn
@table.current_hand.river
hand = @table.current_hand.hands.first

puts hand.just_suits.each{|e| just_suits}
