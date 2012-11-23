require_relative "./player"
require_relative "./contracts/ai_player_contracts"

class AIPlayer < Player
  include AIPlayerContracts
  # Creates the AI Player with the given difficulty is the probability that
  # the AI makes a random move as opposed to a smart one

  
  
  def initialize(difficulty)
    initialize_preconditions(difficulty)
    @difficulty = difficulty = 0
    
    @SEQ_WEIGHT = 2
    @MY_MOVE_SENTINEL = "!"
    @NULL_SENTINEL = "^"
    
    initialize_postconditions()
  end

  # TODO: Write the AI algorithm with the @difficulty parameter used as a
  # probability that the bot makes a random (stupid) move
  def do_move(grid, other_players)
    do_move_preconditions(grid, other_players)
    class_invariant()
    # random column for now
    random_chance = rand()
    best_move = -1

    if(random_chance < @difficulty)
      best_move = do_rand_move(grid)
    else
      best_move = strategic_move(other_players, grid)
    end
    
    class_invariant()
    do_move_postconditions(best_move)
    return best_move
  end

  def do_rand_move(grid)
    random = rand(7)
    while grid.is_column_full?(random)
      random = rand(6)
    end

    random
  end

  def description()
    "AI"
  end

  def strategic_move(opponent_data, grid)
    
    opponent_tokens = opponent_data.keys
    opponent_winning_seq = []

    opponent_tokens.each_with_index { |token, index|
      opponent_winning_seq << opponent_data[token]
    }

    currentplayer = opponent_tokens.length()

    best_choice = 0
    found = false

    row_length = grid.get_row_length()
    col_length = grid.get_column_length()
    score = Array.new(opponent_tokens.length() + 1) { Array.new(col_length, 0) }
    row_indicator = buildRowIndicator(grid)

    horizscore(currentplayer,@token, @winning_token, grid, row_indicator, score)
    vertscore(currentplayer,@token, @winning_token, grid, row_indicator, score)
    leftdiagscore(currentplayer,@token, @winning_token, grid, row_indicator, score)
    rightdiagscore(currentplayer,@token, @winning_token, grid, row_indicator, score)
    
    #Play to win
    col_length.times { |col|
      if(score[currentplayer][col] >= @SEQ_WEIGHT * @winning_token.length)
        if(row_indicator[col] <= row_length)
          best_choice = col
          found = true
          break
        end
      end
    }

    #determine opponent scores
    if(!found)
      opponent_tokens.each_with_index() { |token, index|

        next unless index != currentplayer
        win_seq = opponent_winning_seq[index]
        token = opponent_tokens[index]

        
        horizscore(index,token, win_seq, grid, row_indicator, score)
        vertscore(index,token, win_seq, grid, row_indicator, score)
        leftdiagscore(index,token, win_seq, grid, row_indicator, score)
        rightdiagscore(index,token, win_seq, grid, row_indicator, score)
      }
    end

    #Play to block win
    if(!found)
      opponent_tokens.each_with_index() { |player, index|
        col_length.times { |col|
          if(score[index][col] >= @SEQ_WEIGHT * opponent_winning_seq[index].length)
            if(row_indicator[col] <= row_length)
              best_choice = col
              found  = true
              break
            end
          end
        }
      }
    end

    #repeat for lower values to find best move
    if(!found)
      (0...@winning_token.length * @SEQ_WEIGHT).each { |i|

        value = @winning_token.length * @SEQ_WEIGHT - i

        col_length.times { |col|
          if(score[currentplayer][col] == value)
            if(row_indicator[col] <= row_length)
              best_choice = col
              found  = true
              break
            end
          end
        }

        break unless !found

        opponent_tokens.each_with_index() { |player, index|
          next unless index != currentplayer
          col_length.times { |col|
            if(score[index][col] == value)
              if(row_indicator[col] <= row_length)
                best_choice = col
                found  = true
                break
              end
            end
          }
          break unless !found
        }

        break unless !found

      }
    end

    if(!found)
      best_choice = rand(0...col_length)
    end

    return best_choice

  end

  def horizscore(player_index, player_token, win_seq, grid, rowindicator, score)

    row_length = grid.get_row_length()
    col_length = grid.get_column_length()
    expected_len = win_seq.length()

    col_length.times{ |i|

      count, checkcol, checkrow = 0, i, rowindicator[i]
      next unless checkrow >= 0

      string = ""

      #left
      j = 0
      while(checkrow < row_length && checkcol> 0  && j < expected_len - 1)
        checkcol -= 1
        break unless prepend_unless_nil(string, grid, checkrow, checkcol)
        j+=1
      end
      
      count, checkcol, checkrow = 0, i, rowindicator[i]
      string << @MY_MOVE_SENTINEL

      #right
      j = 0
      while(checkrow < row_length && checkcol < col_length - 1  && j < expected_len - 1)
        checkcol += 1
        break unless append_unless_nil(string, grid, checkrow, checkcol)
        j+=1
      end


      process_score(win_seq, string, player_token, player_index, score, i)
    }

  end

  def append_unless_nil(result_string, grid, checkrow, checkcol)

    temp = grid[checkrow,checkcol]

    if(temp == nil)
      result_string << @NULL_SENTINEL
      return false
    else
      result_string << grid[checkrow,checkcol].to_s
      return true
    end

  end

  def prepend_unless_nil(result_string, grid, checkrow, checkcol)

    temp = grid[checkrow,checkcol]

    if(temp == nil)
      result_string.insert(0, @NULL_SENTINEL)
      return false
    else
      result_string.insert(0, grid[checkrow,checkcol].to_s)
      return true
    end

  end

  def vertscore(player_index,player_token, win_seq, grid, rowindicator, score)

    row_length = grid.get_row_length()
    col_length = grid.get_column_length()
    expected_len = win_seq.length()

    col_length.times{ |i|

      count, checkrow = 0, rowindicator[i]

      next unless checkrow >= 0

      string = @MY_MOVE_SENTINEL

      j = 0
      while(checkrow < row_length - 1  && j < expected_len - 1)
        checkrow+=1
        break unless append_unless_nil(string, grid, checkrow, i)
        j+=1
      end

      process_score(win_seq, string, player_token, player_index, score, i)
    }

  end

  def leftdiagscore(player_index,player_token, win_seq, grid, rowindicator, score)

    row_length = grid.get_row_length()
    col_length = grid.get_column_length()
    expected_len = win_seq.length()

    col_length.times{ |i|
      count, checkrow, checkcol = 0, rowindicator[i], i
      next unless checkrow >= 0

      string = ""

      j = 0
      while(checkrow > 0 && checkcol > 0 && j < expected_len - 1)
        checkrow-=1
        checkcol-=1
        break unless prepend_unless_nil(string, grid, checkrow, checkcol)
        j+=1
      end

      count, checkcol, checkrow = 0, i, rowindicator[i]
      string << @MY_MOVE_SENTINEL

      j = 0
      while(checkrow < row_length - 1 && checkcol < col_length - 1 && j < expected_len - 1)
        checkrow+=1
        checkcol+=1
        break unless append_unless_nil(string, grid, checkrow, checkcol)
        j+=1
      end

      process_score(win_seq, string, player_token, player_index, score, i)
    }
  end

  def rightdiagscore(player_index,player_token, win_seq, grid, rowindicator, score)
    row_length = grid.get_row_length()
    col_length = grid.get_column_length()
    expected_len = win_seq.length()

    col_length.times{ |i|
      count, checkrow, checkcol = 0, rowindicator[i], i
      next unless checkrow >= 0

      string = ""

      j = 0
      while(checkrow < row_length - 1 && checkcol > 0 && j < expected_len - 1)
        checkrow+=1
        checkcol-=1
        break unless prepend_unless_nil(string, grid, checkrow, checkcol)
        j+=1
      end

      count, checkcol, checkrow = 0, i, rowindicator[i]
      string << @MY_MOVE_SENTINEL

      j = 0
      while(checkrow > 0 && checkcol < col_length - 1 && j < expected_len - 1)
        checkrow-=1
        checkcol+=1
        break unless append_unless_nil(string, grid, checkrow, checkcol)
        j+=1
      end

  
      process_score(win_seq, string, player_token, player_index, score, i)

    }
  end

  def build_value_hash(expected_sequence)
    value_hash = Hash.new(0)
    length = expected_sequence.length()

    length.times { |i|
      next unless i != 0
      temp = expected_sequence[0...i]
      temp << @NULL_SENTINEL
      temp_rev = temp.reverse
      value_hash[temp] = [0..i].length() * @SEQ_WEIGHT + 1
      value_hash[temp_rev] = [0..i].length() * @SEQ_WEIGHT + 1

      temp.insert(0, @NULL_SENTINEL)
      value_hash[temp] = [0..i].length() * @SEQ_WEIGHT + 2

    }

    temp = expected_sequence[0..length]
    value_hash[temp] = temp.length() * @SEQ_WEIGHT

    value_hash
  end

  def process_score(expected_seq, seq, token, player_index, score, column)

    value_hash = build_value_hash(expected_seq)
    
    seq_copy = seq.clone
    seq_len = seq.length
    expected_seq_len = expected_seq.length
    sub_sequences = []

    our_move = seq_copy.index(@MY_MOVE_SENTINEL)
    seq_copy.gsub!(@MY_MOVE_SENTINEL, token)

    upperlimit = our_move + expected_seq_len - 1
    upperlimit = seq_len - 1 unless upperlimit < seq_len
    lowerlimit = our_move - expected_seq_len + 1
    lowerlimit = 0 unless lowerlimit >= 0

    (lowerlimit..upperlimit).each{ |i|

      string = ""
      n = i


      while(n < i + expected_seq_len and n < seq_len)

        if(i > our_move or our_move > n)
          n+=1
          next
        end

        sub_sequences << seq_copy[i..n]
        n+=1
      end

      n = i

      while(n > i - expected_seq_len and n >= 0)
        if(i > our_move or our_move > i)
          n-=1
          next
        end

        sub_sequences << seq_copy[n..i]
        n-=1
      end

    }

    sub_sequences.uniq!

    sub_sequences.each {|sub_seq|
      value = value_hash[sub_seq]

      if(score[player_index][column] < value.to_i)
        score[player_index][column] = value.to_i
      end

    }

  end

  def buildRowIndicator(grid)

    row_length = grid.get_row_length()
    col_length = grid.get_column_length()

    row_indicator = Array.new(7, row_length-1)

    col_length.times { |column|
      row_length.times { |row|
        if grid[row,column] != nil
          row_indicator[column] = row

          if(row == 0)
            row_indicator[column] = -1
          else
            row_indicator[column] = row - 1
          end

          break
        end
      }
    }

    return row_indicator

  end

end