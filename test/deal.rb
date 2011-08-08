require '../lib/holdem.rb'


@table = Table.new
10.times do 
  Player.new(10000, @table)
end

@table.new_hand(true)
@table.new_hand
for hand in @table.current_hand.hands
  puts hand.to_s
end

@table.current_hand.flop
@table.current_hand.turn
puts @table.current_hand.river
puts "DONE"
