class Table
  
  attr_accessor :players
  attr_reader :archive_hands, :current_hand
  
  def initialize
    @players = []
    @archive_hands = []
  end
  
  def new_hand
    @archive_hands << @current_hand if @current_hand
    @current_hand = Holdem.new(self)
    @current_hand.deal
  end  
  
  def current_game
    @current_hand
  end
  
  
end