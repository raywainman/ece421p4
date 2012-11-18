require_relative "./player"

class HumanPlayer < Player
  def do_move(player)
    print "Add to column> "
    return gets.to_i
  end

  def description()
    "Human"
  end

  def set_token(token)
    @token = token
  end
end