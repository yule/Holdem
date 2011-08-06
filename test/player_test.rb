require 'helper'

class PlayerTest < Test::Unit::TestCase
  
  def setup
    Holdem.new
  end  
  
  def test_initializes_ok
    assert_instance_of Player, Player.new
  end  

  def test_player_has_stack
    player = Player.new(10000)
    assert_equal 10000, player.stack
  end
  
  ################# Preflop #######################
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

  def test_player_can_reraise
    player = Player.new(30)
    playerb = Player.new(20)
    player.bet(7)
    playerb.bet(15)
    player.call
    assert_equal 15, player.stack
    assert_equal 5, playerb.stack
  end  
  
  def test_calling_station_works
    player = Player.new(30)
    playerb = Player.new(20)
    calling_station = Player.new(20)
    player.bet(7)
    calling_station.call
    playerb.bet(15)
    player.call
    calling_station.call
    assert_equal 15, player.stack
    assert_equal 5, playerb.stack
    assert_equal 5, calling_station.stack
  end  

  def test_all_in_allows_more_betting
    player = Player.new(30)
    playerb = Player.new(20)
    calling_station = Player.new(6)
    player.bet(7)
    calling_station.call
    playerb.bet(15)
    player.call
    assert_equal 15, player.stack
    assert_equal 5, playerb.stack
    assert_equal 0, calling_station.stack
  end
  
  def test_player_can_fold
    player = Player.new(30)
    playerb = Player.new(20)
    player.bet(7)
    playerb.fold
    assert_equal 23, player.stack
    assert_equal 20, playerb.stack
  end  
  
  def test_player_can_raise_by
    player = Player.new(30)
    playerb = Player.new(40)
    player.bet(10)
    playerb.raise_by(10)
    player.call
    assert_equal 10, player.stack
    assert_equal 20, playerb.stack
  end  
  
  def test_player_can_raise_to
    player = Player.new(30)
    playerb = Player.new(40)
    player.bet(10)
    playerb.raise_to(20)
    player.call
    assert_equal 10, player.stack
    assert_equal 20, playerb.stack
  end  
  
  
  
end
 


