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
end