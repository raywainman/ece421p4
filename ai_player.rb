class AIPlayer < Player
  def do_move(game)
    # random column for now
    random = rand(6)
    while game.is_column_full?(random)
      random = rand(6)
    end
    return random
  end

  def description()
    "AI"
  end

  def set_token(token)
    @token = token
  end
end