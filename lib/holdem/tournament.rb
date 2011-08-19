class Tournament
  
  attr_accessor :players, :tables, :options, :small_blind, :big_blind
  
  def initialize(options={})
    @players = []
    @tables = []
    @options = {
      :seats_per_table=>9,
      :starting_stack=>1000,
      :structure=>[[10,20,0],[20,50,0]]
    }.merge(options)
    
  end
    
  def register(player) 
    player.stack = options[:starting_stack]
    @players << player
  end   

  def seat_players
     @tables << Table.new
     for player in @players
       @tables << Table.new if @tables.last.players.size == options[:seats_per_table]
       @tables.last << player
     end 
  end

  def shuffle_up_and_deal
    @small_blind = options[:structure][0][0]
    @big_blind = options[:structure][0][1]
    @tables.each{|t| t.new_hand(true)}
  end

end
