require 'helper'

class PlayerTest < Test::Unit::TestCase
  
  def test_initializes_ok
    assert_instance_of Player, Player.new
  end  

  def test_player_has_stack
    player = Player.new(10000)
    assert_equal 10000, player.stack
  end
  
  def test_player_can_bet
    player = Player.new(10)
    player.bet(2)
    assert_equal 8, player.stack 
  end 

  def test_player_cant_bet_more_than_stack
    player = Player.new(10)
    player.bet(11)
    assert_equal 0, player.stack 
  end

  def test_player_can_call
    player = Player.new(10)
    playerb = Player.new(20)
    player.bet(7)
    playerb.call
    assert_equal 3, player.stack
    assert_equal 13, playerb.stack
  end

end
 
