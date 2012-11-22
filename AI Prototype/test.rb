class Test
  def initialize()
    @grid = Array.new(6) { Array.new(7) }

    @grid[1][0] = 1
    @grid[1][1] = "o"
    #@grid[2][2] = 1
    @grid[3][3] = "t"
    @grid[4][4] = "t"
    @grid[5][5] = 1
    @grid[4][6] = 1
    @grid[5][6] = 1

    @grid[2][5] = 1

    @grid[0][0] = "2"
    @grid[0][1] = "t"
    @grid[3][2] = "t"

    @grid[0][4] = 1
    @grid[0][5] = 1
    @grid[0][6] = 1

    @grid[1][3] = 1

  end

  def buildRowIndicator()

    row_length = @grid.length()
    col_length = @grid[0].length()

    row_indicator = Array.new(7, row_length)

    col_length.times { |column|
      row_length.times { |row|
        if @grid[row][column] != nil
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

  def get_best_move(players, win_seq, grid)
    players = [[],[],[]]

    expected_len = win_seq.length
    best_choice = 0

    currentplayer = 0
    current_token = "o"

    found = false
    max_found_value = 0

    row_length = @grid.length()
    col_length = @grid[0].length()
    score = Array.new(players.length()) { Array.new(col_length, 0) }
    row_indicator = buildRowIndicator()

    horizscore(currentplayer,current_token, win_seq, grid, row_indicator, score)
    vertscore(currentplayer,current_token, win_seq, grid, row_indicator, score)
    leftdiagscore(currentplayer,current_token, win_seq, grid, row_indicator, score)
    rightdiagscore(currentplayer,current_token, win_seq, grid, row_indicator, score)

    #Play to win
    col_length.times { |col|
      if(score[currentplayer][col] >= 2* expected_len)
        if(row_indicator[col] <= row_length)
          best_choice = col
          found = true
          break
        end
      end
    }

    #determine opponent scores
    if(!found)
      players.each_with_index() { |player, index|

        next unless index != currentplayer
        token = "t"#player.get_token

        horizscore(index,token, win_seq, grid, row_indicator, score)
        vertscore(index,token, win_seq, grid, row_indicator, score)
        leftdiagscore(index,token, win_seq, grid, row_indicator, score)
        rightdiagscore(index,token, win_seq, grid, row_indicator, score)
      }
    end

    #Play to block win
    if(!found)
      players.each_with_index() { |player, index|
        col_length.times { |col|
          if(score[index][col] >= 2 * expected_len)
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

    #for expected_len * 2 -1 to 0
    if(!found)
      (0...expected_len*2).each { |i|

        value = expected_len*2 - i
        #puts "v: " + value.to_s
        
        col_length.times { |col|
          puts score[currentplayer][col]
          if(score[currentplayer][col] == value)
            if(row_indicator[col] <= row_length)
              best_choice = col
              found  = true
              break
            end
          end
        }

        break unless !found
        
        players.each_with_index() { |player, index|
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

  def horizscore(player_index, player_token, win_seq, gridx, rowindicator, score)

    row_length = @grid.length()
    col_length = @grid[0].length()
    expected_len = win_seq.length()

    col_length.times{ |i|

      count, checkcol, checkrow = 0, i, rowindicator[i]
      next unless checkrow >= 0

      string = ""

      #left
      j = 0
      while(checkrow < row_length && checkcol> 0  && j < expected_len - 1)
        checkcol -= 1
        break unless prepend_unless_nil(string, @grid, checkrow, checkcol)
        j+=1
      end

      count, checkcol, checkrow = 0, i, rowindicator[i]
      string << "!"

      #right
      j = 0
      while(checkrow < row_length && checkcol < col_length - 1  && j < expected_len - 1)
        checkcol += 1
        break unless append_unless_nil(string, @grid, checkrow, checkcol)
        j+=1
      end

      #get count values
      count = -1#get_fing_func_to_get_value()

      if (count > score[player_index][i])
        score[player_index][i] = count;
      end

      process_score(win_seq, string, player_token, player_index, score, i)

      puts string

    }

  end

  def append_unless_nil(result_string, grid, checkrow, checkcol)

    temp = @grid[checkrow][checkcol]

    if(temp == nil)
      result_string << "^"
      return false
    else
      result_string << @grid[checkrow][checkcol].to_s
      return true
    end

  end

  def prepend_unless_nil(result_string, grid, checkrow, checkcol)

    temp = @grid[checkrow][checkcol]

    if(temp == nil)
      result_string.insert(0, "^")
      return false
    else
      result_string.insert(0, @grid[checkrow][checkcol].to_s)
      return true
    end

  end

  def vertscore(player_index,player_token, win_seq, grid, rowindicator, score)

    row_length = @grid.length()
    col_length = @grid[0].length()
    expected_len = win_seq.length()

    col_length.times{ |i|

      count, checkrow = 0, rowindicator[i]

      next unless checkrow >= 0

      string = "!"

      j = 0
      while(checkrow < row_length - 1  && j < expected_len - 1)
        checkrow+=1
        break unless append_unless_nil(string, @grid, checkrow, i)
        j+=1
      end

      process_score(win_seq, string, player_token, player_index, score, i)

      #puts self.to_s
      puts string

    }

  end

  def leftdiagscore(player_index,player_token, win_seq, grid, rowindicator, score)

    row_length = @grid.length()
    col_length = @grid[0].length()
    expected_len = win_seq.length()

    col_length.times{ |i|
      count, checkrow, checkcol = 0, rowindicator[i], i
      next unless checkrow >= 0

      string = ""

      j = 0
      while(checkrow > 0 && checkcol > 0 && j < expected_len - 1)
        checkrow-=1
        checkcol-=1
        break unless prepend_unless_nil(string, @grid, checkrow, checkcol)
        j+=1
      end

      count, checkcol, checkrow = 0, i, rowindicator[i]
      string << "!"

      j = 0
      while(checkrow < row_length - 1 && checkcol < col_length - 1 && j < expected_len - 1)
        checkrow+=1
        checkcol+=1
        break unless append_unless_nil(string, @grid, checkrow, checkcol)
        j+=1
      end

      process_score(win_seq, string, player_token, player_index, score, i)

      #puts self.to_s
      puts string
    }
  end

  def rightdiagscore(player_index,player_token, win_seq, grid, rowindicator, score)
    row_length = @grid.length()
    col_length = @grid[0].length()
    expected_len = win_seq.length()

    col_length.times{ |i|
      count, checkrow, checkcol = 0, rowindicator[i], i
      next unless checkrow >= 0

      string = ""

      j = 0
      while(checkrow < row_length - 1 && checkcol > 0 && j < expected_len - 1)
        checkrow+=1
        checkcol-=1
        break unless prepend_unless_nil(string, @grid, checkrow, checkcol)
        j+=1
      end

      count, checkcol, checkrow = 0, i, rowindicator[i]
      string << "!"

      j = 0
      while(checkrow > 0 && checkcol < col_length - 1 && j < expected_len - 1)
        checkrow-=1
        checkcol+=1
        break unless append_unless_nil(string, @grid, checkrow, checkcol)
        j+=1
      end

      process_score(win_seq, string, player_token, player_index, score, i)

      #puts self.to_s
      puts string
    }
  end

  def build_value_hash(expected_sequence)
    value_hash = Hash.new(0)
    length = expected_sequence.length()

    length.times { |i|
      next unless i != 0
      temp = expected_sequence[0...i]
      temp << "^"
      temp_rev = temp.reverse
      value_hash[temp] = [0..i].length() * 2 + 1
      value_hash[temp_rev] = temp.length()

      temp.insert(0, "^")
      value_hash[temp] = [0..i].length() * 2 + 2

    }

    temp = expected_sequence[0..length]
    value_hash[temp] = temp.length()*2

    puts "----------" + value_hash.to_s
    value_hash
  end

  def process_score(expected_seq, seq, token, player_index, score, column)

    value_hash = build_value_hash(expected_seq)

    seq_copy = seq.clone
    seq_len = seq.length
    expected_seq_len = expected_seq.length
    sub_sequences = []

    #seq_copy.gsub!("^", "")
    puts seq_copy
    our_move = seq_copy.index('!')
    seq_copy.gsub!('!', token)

    upperlimit = our_move + expected_seq_len - 1
    upperlimit = seq_len - 1 unless upperlimit < seq_len
    lowerlimit = our_move - expected_seq_len + 1
    lowerlimit = 0 unless lowerlimit >= 0

    puts our_move
    puts "ul: " + upperlimit.to_s
    puts "ll: " + lowerlimit.to_s

    (lowerlimit..upperlimit).each{ |i|

      string = ""
      n = i

      puts expected_seq_len
      puts n

      while(n < i + expected_seq_len and n < seq_len)

        if(i > our_move or our_move > n)
          n+=1
          next
        end

        puts "A:"+seq_copy[i..n].to_s
        sub_sequences << seq_copy[i..n]
        n+=1
      end

      puts "-----------"
      n = i

      while(n > i - expected_seq_len and n >= 0)
        if(i > our_move or our_move > i)
          n-=1
          next
        end

        puts "B:"+seq_copy[n..i].to_s
        sub_sequences << seq_copy[n..i]
        n-=1
      end

    }

    sub_sequences.uniq!

    puts sub_sequences.to_s

    sub_sequences.each {|sub_seq|
      puts sub_seq
      value = value_hash[sub_seq]

      if(score[player_index][column] < value.to_i)
        score[player_index][column] = value.to_i
      end

    }

    puts "score: " + score.to_s
  end

  def to_s()
    @grid.each { |r|
      puts r.to_s + "\n"
    }
  end

end

test = Test.new()
grid = Array.new(6) { Array.new(7) }
puts test.to_s
test.get_best_move(nil, "otto", grid)
