require 'helper'

class PlayerTest < Test::Unit::TestCase
  
  def setup
    @table = Table.new
    Player.new(10, @table)
    Player.new(20, @table)
    Player.new(30, @table)
    Player.new(20, @table)
    Player.new(6, @table)
    Player.new(40, @table)

    @game = @table.new_hand
  end  
  
  def test_initializes_ok
    assert_instance_of Player, Player.new
  end  

  def test_player_has_stack
    player = Player.new(10000, @table)
    assert_equal 10000, player.stack
  end
  
  ################# Preflop #######################
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

  def test_player_can_call
    player = @table.players[0]
    playerb = @table.players[1] 
    player.bet(7)
    playerb.call
    assert_equal 3, player.stack
    assert_equal 13, playerb.stack
  end

  def test_player_can_reraise
    player = @table.players[2]
    playerb = @table.players[1]
    player.bet(7)
    playerb.bet(15)
    player.call
    assert_equal 15, player.stack
    assert_equal 5, playerb.stack
  end  
  
  def test_calling_station_works
    player = @table.players[2]
    playerb = @table.players[1]
    calling_station = @table.players[3]
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
    player = @table.players[2]
    playerb = @table.players[3]
    calling_station = @table.players[4]
    player.bet(7)
    calling_station.call
    playerb.bet(15)
    player.call
    assert_equal 15, player.stack
    assert_equal 5, playerb.stack
    assert_equal 0, calling_station.stack
  end
  
  def test_player_can_fold
    player = @table.players[2]
    playerb = @table.players[1]
    player.bet(7)
    playerb.fold
    assert_equal 23, player.stack
    assert_equal 20, playerb.stack
  end  
  
  def test_player_can_raise_by
    player = @table.players[2]
    playerb = @table.players[5]
    player.bet(10)
    playerb.raise_by(10)
    player.call
    assert_equal 10, player.stack
    assert_equal 20, playerb.stack
  end  
  
  def test_player_can_raise_to
    player = @table.players[2]
    playerb = @table.players[5]
    player.bet(10)
    playerb.raise_to(20)
    player.call
    assert_equal 10, player.stack
    assert_equal 20, playerb.stack
  end  
  
  def test_flop_resets_bet
    player = @table.players[2]
    playerb = @table.players[5]
    player.bet(10)
    playerb.call
    assert_equal 30, playerb.stack
    @game.flop
    player.raise_by(5)
    playerb.call
    assert_equal 15, player.stack
    assert_equal 25, playerb.stack
  end  
  
end
 


