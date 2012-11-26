require_relative "./connect4"
require_relative "./otto"
require_relative "./human_player"
require_relative "./ai_player"
require_relative "./game"

class MainController
  def initialize(view)
    @view = view
  end

  # Quits the application
  def gtk_main_quit
    Gtk.main_quit
    exit!
  end

  # Plus button clicked
  def on_plus_clicked
    text = @view.entry.text.to_i
    if text < 2
      @view.entry.text = (text + 1).to_s()
    elsif text < 4 && @view.connect4_radiobutton.active?
      @view.entry.text = (text + 1).to_s()
    end
  end

  # Minus button clicked
  def on_minus_clicked
    text = @view.entry.text.to_i
    if text > 1
      @view.entry.text = (text - 1).to_s()
    end
  end

  def on_humans_changed
    sum = @view.humans.text.to_i + @view.computers.text.to_i
    if @view.otto_radiobutton.active?
      if sum > 2
        @view.humans.text = 2.to_s
        @view.computers.text = 0.to_s
      elsif sum == 1
        @view.computers.text = 1.to_s
      end
    else
      if sum > 4
        difference = 4 - @view.humans.text.to_i
        @view.computers.text = difference.to_s
      elsif sum == 1
        @view.computers.text = 1.to_s
      end
    end
  end

  def on_computers_changed
    on_humans_changed()
  end

  # Radio button (for game mode) changed, update player count
  def on_mode_changed
    if @view.otto_radiobutton.active?
      if @view.humans.text.to_i >= 2
        @view.humans.text = 2.to_s
        @view.computers.text = 0.to_s
      end
      if @view.computers.text.to_i > 1
        @view.computers.text = 1.to_s
      end
    end
  end

  #Starts the game by saving the game mode in @game_mode
  #as a string, and shows the window where the board is.
  def on_start_clicked
    #Set game type based on radio buttons
    if @view.connect4_radiobutton.active?
      game_type = Connect4.new
    else
      game_type = Otto.new
    end
    players = []
    @view.humans.text.to_i.times {
      players << HumanPlayer.new
    }
    difficulty = 0
    if @view.easy.active?
      difficulty = 0.80
    elsif @view.medium.active?
      difficulty = 0.40
    end
    @view.computers.text.to_i.times {
      players << AIPlayer.new(difficulty)
    }
    @game = Game.new(game_type, players, @view)
    @view.reset_board_images()
    #Then show the board
    @view.show_board(game_type.game_name + " Playing Area")
  end

  #When the mouse is clicked inside the board. Here is where
  #the state object is sent to the model
  def on_eventbox1_button_release_event
    @game.make_move(@view.col_selected)
  end

  #When the mouse is moved over the board
  def on_eventbox1_motion_notify_event(widget,event)
    #get the column
    @view.set_column_selected(event.x)
    #show corresponding arrow
    @view.show_arrow()
  end

  #When the user clicks on the button contained
  #in the winner dialog. Simply hides the two windows  
  def on_return_to_main_button_clicked
    @view.win_dialog.hide()
    @view.board.hide()    
  end
  
  #Signal handler that prevents the board from being deleted
  #and hides it instead
  def on_board_delete_event
    @view.board.hide_on_delete()
  end
  
  def on_win_dialog_delete_event
    @view.board.hide()
    @view.win_dialog.hide_on_delete()
  end
  
end