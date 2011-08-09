require 'helper'

class BettingTest < Test::Unit::TestCase

  def setup
    @table = Table.new
    Player.new(10, @table)
    Player.new(20, @table)
    Player.new(30, @table)
    Player.new(20, @table)
    Player.new(6, @table)
    Player.new(40, @table)
    @game = @table.new_hand(true)
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
  
  def test_full_hand_betting
    player1 = @table.players[0]
    player2 = @table.players[1]
    player3 = @table.players[2]
    player4 = @table.players[3]
    player5 = @table.players[4]
    player6 = @table.players[5]
    
    player1.bet(10); player2.call; player3.call;  player4.call; player5.call; player6.call
    @game.flop
    player1.check; player2.check; player3.raise_to(10); player4.call; player5.call; player6.call; player1.call; player2.call
    @game.turn
    player1.check; player2.check; player3.check; player4.check; player5.check; player6.bet(5); player1.call; player2.fold; player3.fold; player4.call; player5.call
    @game.river
    player1.check; player3.check; player4.check; player5.check; player6.check
    
    assert_equal 0, player1.stack
    assert_equal 0, player2.stack
    assert_equal 10, player3.stack
    assert_equal 0, player4.stack
    assert_equal 0, player5.stack
    assert_equal 15, player6.stack

  end      

end