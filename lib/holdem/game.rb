


class Holdem < Deck::Game

  #overrides the default number of cards to be 2
  def initialize(h=9, c=2)
    super(h,c)
  end

end
 
