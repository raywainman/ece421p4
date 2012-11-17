# Abstract game type class
class GameType
  # Gets the label that should be given to the given player number
  def get_player_label(player)
    raise "Not implemented"
  end

  # Returns the maximum number of players allowed for this game type
  def max_players()
    raise "Not implemented"
  end

  # Returns the minimum number of players needed for this game type
  def min_players()
    raise "Not implemented"
  end

  # Returns the name of the game
  def game_name()
    raise "Not implemented"
  end

  # Evaluates the grid and returns the winning player (if there is a win),
  # -1 otherwise
  def evaluate_win(grid)
    raise "Not implemented"
  end
end