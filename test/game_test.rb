require 'helper'

class GameTest < Test::Unit::TestCase
  
  def test_initializes_ok
    assert_instance_of Game, Game.new
    assert_kind_of Game, Holdem.new 
 end  
  
  
  def test_deals_ok
    game = Holdem.new(10)
    game.deal
    assert_equal 10, game.hands.size
    
    (1..10).each do |n|
      assert_equal 2, game.hands[n-1].size
    end
    
  end  
  
  
end
