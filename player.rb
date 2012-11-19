# Abstract Player class
class Player
  # Computes a move to be played by the player, returns the column number to
  # play
  def do_move(game)
    raise "Not Implemented"
  end

  # Returns a string description of the type of player
  def description()
    raise "Not Implemented"
  end
  
  # Sets the token for this particular player
  def set_token(token)
    raise "Not Implemented"
  end
end