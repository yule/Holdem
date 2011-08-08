require 'helper'

class TableTest < Test::Unit::TestCase
  
  def test_can_create_table
    assert_instance_of Table, Table.new
  end  
  
  def test_can_add_players
    table = Table.new 
    10.times do
      table.players << Player.new(10000,table)
    end
    
    assert_equal 10, table.players.size
  end  
  
end  