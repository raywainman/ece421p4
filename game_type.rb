# Abstract game type class
class GameType
  # Gets the label that should be given to the given player number
  def get_player_label(player)
    raise "Not implemented"
  end

  # Evaluates the grid and returns the winning player (if there is a win),
  # -1 otherwise
  def evaluate_win(grid)
    raise "Not implemented"
  end

  # Returns the maximum number of players that can play in this mode
  def max_players()
    raise "Not implemented"
  end

  # Returns the minimum number of players needed to play in this mode
  def min_players()
    raise "Not implemented"
  end

  # Returns a string representing the game
  def game_name()
    raise "Not implemented"
  end
end