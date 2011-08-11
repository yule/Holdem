require '../lib/holdem.rb'


@table = Table.new
10.times do 
  Player.new(10000, @table)
end

@table.new_hand(true)
@table.new_hand

@table.current_hand.flop
@table.current_hand.turn
puts @table.current_hand.river.inspect
hands = @table.current_hand.hands.sort.reverse
hands.each{|n|
  puts "HAND : #{n.inspect}"
}

