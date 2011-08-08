require 'helper'

class HandTest < Test::Unit::TestCase
  
  def setup 
    @community = [Card.new(10, "spades"), Card.new("J", "spades"), Card.new("Q", "Spades"), Card.new("K","Spades"), Card.new("J","Hearts")]
  end

 

  def test_can_detect_royal_flush
    hand = Hand.new   
    hand << Card.new("A", "Spades")
    hand << Card.new("4", "Clubs")
    assert hand.is_royal_flush?
  end 

  def test_can_detect_straight_flush
    hand = Hand.new   
    hand << Card.new("9", "Spades")
    hand << Card.new("9", "Hearts")
    assert hand.is_straight_flush?
  end
  
  def test_can_detect_quads
    hand = Hand.new
    hand << Card.new("J","Clubs")
    hand << Card.new("J","Diamonds")
    assert hand.is_four_of_a_kind?
  end

  def test_can_detect_full_house
    hand = Hand.new
    hand << Card.new("J","Clubs")
    hand << Card.new("Q","Diamonds")
    assert hand.is_four_of_a_kind?
  end

  def test_can_detect_flush
    hand = Hand.new
    hand << Card.new("2","Spades")
    hand << Card.new("5","Diamonds")
    assert hand.is_flush?
  end

  def test_can_detect_straight
    hand = Hand.new
    hand << Card.new("2","Hearts")
    hand << Card.new("9","Diamonds")
    assert hand.is_straight?
  end
  
  def test_can_detect_trips
    hand = Hand.new
    hand << Card.new("2","Hearts")
    hand << Card.new("J","Diamonds")
    assert hand.is_three_of_a_kind?
  end

  def test_can_detect_two_pair
    hand = Hand.new
    hand << Card.new("2","Hearts")
    hand << Card.new("2","Diamonds")
    assert hand.is_two_pair?
  end
 
  def test_can_detect_one_pair?
    hand = Hand.new
    hand << Card.new("2","Hearts")
    hand << Card.new("3","Diamonds")
    assert hand.is_one_pair?
  end


end
 


