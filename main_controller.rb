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

  # Radio button (for game mode) changed, update player count
  def on_mode_changed
    if @view.otto_radiobutton.active? && @view.entry.text.to_i > 2
      @view.entry.text = 2.to_s
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
    @view.entry.text.to_i.times { 
      players << HumanPlayer.new
    }
    @game = Game.new(game_type, players, @view)
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

end