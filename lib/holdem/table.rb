class Table
  
  attr_accessor :players
  attr_reader :archive_hands, :current_hand, :action_on, :tournament
  
  def initialize(t = Tournament.new)
    @players = []
    @archive_hands = []
    @tournament = t
  end
  
  def new_hand(first_hand = false)
    @archive_hands << @current_hand if @current_hand
    @players << @players.shift unless first_hand
    @current_hand = Holdem.new(self)
    @current_hand.deal
    pre_flop_action
    @current_hand
  end  
 
  def pre_flop_action
    post_small_blind
    post_big_blind
    @action_on = @players[3]
  end
 
  def action_on
    @action_on
  end 

  def current_game
    @current_hand
  end
  
  def dealer
    @players.first
  end
  
  #add a player to the table
  def <<(player)
    @players << player
  end 
  
  private 
    def post_small_blind
      @players[1].bet(@tournament.small_blind) if @players[1]
    end
    def post_big_blind
      @players[2].bet(@tournament.big_blind) if @players[2]
    end 

end
