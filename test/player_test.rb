require 'helper'

class PlayerTest < Test::Unit::TestCase

  def setup
    @table = Table.new
    Player.new(10, @table)
    @table.new_hand(true)
  end
  
  def test_initializes_ok
    assert_instance_of Player, Player.new
  end  

  def test_player_has_stack
    player = Player.new(10000, @table)
    assert_equal 10000, player.stack
  end
  
  def test_player_can_bet
    player = @table.players.first
    player.bet(2)
    assert_equal 8, player.stack 
  end 

  def test_player_cant_bet_more_than_stack
    player = @table.players.first
    player.bet(11)
    assert_equal 0, player.stack 
  end
  
  
  
end
 


