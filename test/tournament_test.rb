require 'helper'

class TournamentTest < Test::Unit::TestCase
 
  def test_can_create_tournament
    assert_instance_of Tournament, Tournament.new
  end

  def test_can_register_player
    t = Tournament.new
    t.register(Player.new)
    assert_not_nil t.players
  end

  def test_can_seat_players
   t = Tournament.new
   t.register(Player.new)
   t.register(Player.new)
   t.seat_players
   assert_equal 1, t.tables.size
   assert_equal 2, t.tables[0].players.size
  end


  def test_doesnt_put_every_player_on_same_table
    t = Tournament.new
    11.times {t.register(Player.new)}
    t.seat_players
    assert_equal 2, t.tables.size
  end

  def test_can_initialize_seats_per_table
    t = Tournament.new({:seats_per_table=>6})
    13.times {t.register(Player.new)}
    t.seat_players
    assert_equal 3, t.tables.size
  end
   
  def test_can_initialize_starting_stack
    t = Tournament.new({:starting_stack=>10000})
    t.register(Player.new)
    assert_equal 10000, t.players.first.stack
  end 

  def test_can_shuffle_up_and_deal
    t = Tournament.new
    100.times {t.register(Player.new())}
    t.seat_players
    t.shuffle_up_and_deal
    assert_not_nil t.tables.first.current_hand
  end 



end 
