require 'helper'

class HandTest < Test::Unit::TestCase
  
  def setup 
    community = [Card.new(10, "spades"), Card.new("Jack", "spades"), Card.new("Queen", "Spades"), Card.new("King","Spades"), Card.new("Jack","Hearts")]
    table = Table.new
    Player.new(10000, table)
    Player.new(10000, table)
    game = table.new_hand
    game.board = community
    @hand = Hand.new
    @hand.game = game
    @hand2 = Hand.new
    @hand2.game = game
  end
  
  def test_has_7_cards
    @hand << Card.new("Ace", "Spades")
    @hand << Card.new("4", "Clubs")
    assert_equal 7, @hand.full_hand.size
  end

  def test_can_detect_royal_flush
    @hand << Card.new("Ace", "Spades")
    @hand << Card.new("4", "Clubs")
    assert @hand.is_royal_flush?
    assert_equal 10, @hand.rank
  end 

  def test_doesnt_falsly_claim_royal
    @hand << Card.new("Ace", "Clubs")
    @hand << Card.new("4", "Spades")
    assert !@hand.is_royal_flush?    
  end

  def test_can_detect_straight_flush   
    @hand << Card.new("9", "Spades")
    @hand << Card.new("9", "Hearts")
    assert @hand.is_straight_flush?
    assert_equal 9, @hand.rank
  end
  
  def test_can_detect_quads
    @hand << Card.new("Jack","Clubs")
    @hand << Card.new("Jack","Diamonds")
    assert @hand.is_four_of_a_kind?
    assert_equal 8, @hand.rank
  end

  def test_can_detect_full_house
    @hand << Card.new("Jack","Clubs")
    @hand << Card.new("Queen","Diamonds")
    assert @hand.is_full_house?
    assert !@hand.is_straight?
    assert_equal 7, @hand.rank
  end

  def test_can_detect_full_house_with_two_trips
    community = [Card.new(10, "spades"), Card.new(10, "diamonds"), Card.new("jack", "Spades"), Card.new("King","Spades"), Card.new("Jack","Hearts")]
    @hand.game.board = community
    @hand << Card.new("Jack","Clubs")
    @hand << Card.new("10","hearts")
    assert @hand.is_full_house?
    assert_equal 7, @hand.rank
  end

  def test_can_detect_two_pair_with_three_pair
    community = [Card.new(10, "spades"), Card.new(10, "diamonds"), Card.new("jack", "Spades"), Card.new("King","Spades"), Card.new("Jack","Hearts")]
    @hand.game.board = community
    @hand << Card.new(2,"Clubs")
    @hand << Card.new(2,"hearts")
    assert @hand.is_two_pair?
  end

  def test_can_detect_flush
    @hand << Card.new("2","Spades")
    @hand << Card.new("5","Diamonds")
    assert @hand.is_flush?
    assert_equal 6, @hand.rank
  end

  def test_can_detect_straight
    @hand << Card.new("2","Hearts")
    @hand << Card.new("9","Diamonds")
    assert @hand.is_straight?
    assert_equal 5, @hand.rank
  end
  
  def test_can_detect_straight_from_ace_up
    community = [Card.new("Ace", "spades"), Card.new(2, "diamonds"), Card.new(3, "Spades"), Card.new("King","Spades"), Card.new("Jack","Hearts")]
    @hand.game.board = community
    @hand << Card.new(4,"Clubs")
    @hand << Card.new(5,"hearts")
    assert @hand.is_straight?
  end
   
 
  def test_can_detect_trips
    @hand << Card.new("2","Hearts")
    @hand << Card.new("Jack","Diamonds")
    assert @hand.is_three_of_a_kind?
    assert_equal 4, @hand.rank
  end

  def test_can_detect_two_pair
    @hand << Card.new("2","Hearts")
    @hand << Card.new("2","Diamonds")
    assert @hand.is_two_pair?
    assert_equal 3, @hand.rank
  end
 
  def test_can_detect_one_pair?
    @hand << Card.new("2","Hearts")
    @hand << Card.new("3","Diamonds")
    assert @hand.is_one_pair?
    assert_equal 2, @hand.rank
  end

  def test_can_compare
    @hand << Card.new("9", "Spades")
    @hand << Card.new("9", "Hearts")
    
    @hand2 << Card.new("2","Hearts")
    @hand2 << Card.new("Jack","Diamonds")
    
    assert @hand > @hand2
    assert @hand2 < @hand
  end
  
  def test_can_distguish_between_same_hand
    @hand << Card.new("6", "Diamonds")
    @hand << Card.new("6", "Hearts")
    
    @hand2 << Card.new("7","Hearts")
    @hand2 << Card.new("7","Diamonds")
    assert @hand < @hand2
    assert @hand2 > @hand
  end

  def test_can_distguish_on_third_kicker
    community = [Card.new("Ace", "spades"), Card.new("Ace", "diamonds"), Card.new(3, "Spades"), Card.new("King","Spades"), Card.new("Jack","Hearts")]
    @hand.game.board = community
    @hand2.game.board = community
    @hand << Card.new(9,"Clubs")
    @hand << Card.new(5,"hearts")
    
    @hand2 << Card.new("8","Hearts")
    @hand2 << Card.new("7","Diamonds")
    assert @hand > @hand2
    assert @hand2 < @hand
  end
  
  def test_can_tie
    community = [Card.new("Ace", "spades"), Card.new("Ace", "diamonds"), Card.new(3, "Spades"), Card.new("King","Spades"), Card.new("Jack","Hearts")]
    @hand.game.board = community
    @hand2.game.board = community
    @hand << Card.new(9,"Clubs")
    @hand << Card.new(5,"hearts")
    
    @hand2 << Card.new("9","Hearts")
    @hand2 << Card.new("7","Diamonds")
    assert @hand == @hand2
  end  
  
  def test_can_distuish_on_full_house
    community = [Card.new("Ace", "spades"), Card.new("Ace", "diamonds"), Card.new(3, "Spades"), Card.new("King","Spades"), Card.new("King","Hearts")]
    @hand.game.board = community
    @hand2.game.board = community
    @hand << Card.new("Ace","Clubs")
    @hand << Card.new(5,"hearts")
    
    @hand2 << Card.new("Kind","Clubs")
    @hand2 << Card.new("7","Diamonds")
    assert @hand > @hand2
    assert @hand2 < @hand
  end

  def test_can_distuish_on_two_pair_kicker
    community = [Card.new("Ace", "spades"), Card.new("Ace", "diamonds"), Card.new(3, "Spades"), Card.new("King","Spades"), Card.new("King","Hearts")]
    @hand.game.board = community
    @hand2.game.board = community
    @hand << Card.new("Queen","Clubs")
    @hand << Card.new(5,"hearts")
    
    @hand2 << Card.new("Jack","Clubs")
    @hand2 << Card.new("7","Diamonds")

    assert @hand > @hand2
    assert @hand2 < @hand
  end

  def test_can_distuish_on_straight
    @hand << Card.new("9", "Hearts")
    @hand << Card.new("5", "Hearts")
    
    @hand2 << Card.new("Ace","Hearts")
    @hand2 << Card.new(2,"Diamonds")
    
    assert @hand < @hand2
    assert @hand2 > @hand

  end


  def test_can_distinguish_on_flush
    community = [Card.new("Ace", "spades"), Card.new(2, "spades"), Card.new(3, "Spades"), Card.new("King","Spades"), Card.new(6,"Hearts")]
    @hand.game.board = community
    @hand2.game.board = community
    @hand << Card.new("Queen","Clubs")
    @hand << Card.new(5,"spades")
    
    @hand2 << Card.new("Jack","Spades")
    @hand2 << Card.new("7","Diamonds")

    assert @hand < @hand2
    assert @hand2 > @hand
  
  end

end

