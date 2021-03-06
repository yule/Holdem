require 'helper'

class GameTest < Test::Unit::TestCase
  
  def setup
    @tbl = Table.new
    10.times do 
      Player.new(10000, @tbl)
    end
  end
  
  
  
  def test_initializes_ok
    assert_instance_of Holdem, Holdem.new(@tbl)
    assert_kind_of Game, Holdem.new(@tbl) 
  end  
  
  
  def test_deals_ok
    game = Holdem.new(@tbl)
    game.deal
    assert_equal 10, game.hands.size
    
    (1..10).each do |n|
      assert_equal 2, game.hands[n-1].size
    end
    
  end  

  def test_can_flop
    game = Holdem.new(@tbl)
    game.deal
    game.flop
    assert_equal 3, game.board.size
  end
  
  def test_can_turn
    game = Holdem.new(@tbl)
    game.deal
    game.flop
    game.turn
    assert_equal 4, game.board.size
  end  

  def test_can_river
    game = Holdem.new(@tbl)
    game.deal
    game.flop
    game.turn
    game.river
    assert_equal 5, game.board.size
  end  
  
  
end
