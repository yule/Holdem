require 'helper'

class TableTest < Test::Unit::TestCase
  
  def test_can_create_table
    assert_instance_of Table, Table.new
  end  
  
  def test_can_add_players
    table = Table.new 
    10.times do
      Player.new(10000,table)
    end
    
    assert_equal 10, table.players.size
  end  
  
  
  def test_changes_dealers
    table = Table.new
    (1..10).each{|n|
      Player.new(n, table)
    }
    table.new_hand(true)
    assert_equal 1, table.dealer.stack
    table.new_hand
    assert_equal 2, table.dealer.stack
  end  
  
  
  
  
end  