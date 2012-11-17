class Game
  
  # grid[row][col]
  
  def initialize(game_type, players)
    #initalize_preconditions(game_type, players)
    @game_type = game_type
    @players = players
    @grid = Array.new(6) { Array.new(7) { "-" } }
    # Build grid based on game_type value
    #initialize_postconditions()
  end
  
  def play()
    # Game loop
    # Get move from each player
    # Check for winning condition
  end
  
  def make_move(player, column)
    
  end
  
  def to_s
    str = ""
    @grid.each { |row|
      row.each { |element|
        str << element + " "
      }
      str << "\n"
    }
    return str
  end
end

game = Game.new("bla", 4)
puts game.to_s