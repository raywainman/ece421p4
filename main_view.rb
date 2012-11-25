require "rubygems"
require "gtk2"

require_relative "./main_controller"
require_relative "./contracts/main_view_contracts"

# User interface for the connect4/otto game

# Author:: Dustin Durand (dddurand@ualberta.ca)
# Author:: Kenneth Rodas (krodas@ualberta.ca)
# Author:: Raymond Wainman (wainman@uablerta.ca)
# (ECE 421 - Assignment #4)

class MainView
  include MainViewContracts

  attr_reader :spinner, :entry, :aboutdialog, :board, :boardstatusbar, :eventbox,
  :connect4_radiobutton, :otto_radiobutton, :arrows, :imageArray, :col_selected

  @col_selected=0
  # Initializes GUI via .glade file and gets all the widgets
  def initialize()
    initialize_preconditions()
    Gtk.init
    @builder = Gtk::Builder::new
    @builder.add_from_file("GUI.glade")
    self.get_all_widgets()
  end

  def set_controller(controller)
    @controller = controller
    @builder.connect_signals{ |handler| controller.method(handler) }
  end

  def show
    @builder.get_object("mainMenu").show()
    Gtk.main()
  end

  def show_board(string)
    @board.title=string
    @board.show()
  end

  # Gets all widgets into useful class variables
  def get_all_widgets
    #Get all miscellaneous widgets
    @spinner=@builder.get_object("spinner1")
    @entry=@builder.get_object("entry1")
    @aboutdialog=@builder.get_object("aboutdialog1")
    @board=@builder.get_object("board")
    @boardstatusbar=@builder.get_object("statusbar2")
    @eventbox=@builder.get_object("eventbox1")
    @connect4_radiobutton=@builder.get_object("radiobutton1")
    @otto_radiobutton=@builder.get_object("radiobutton2")
    #Get all arrows
    @arrows = []
    (1..7).each { |col|
      @arrows << @builder.get_object("arrow" + col.to_s)
    }
    #Get all images
    @imageArray  = Array.new(6) { Array.new(7) }
    count = 0
    @imageArray.each_index  { |row|
      @imageArray[0].each_index { |col|
        imageString = "img" + count.to_s()
        @imageArray[row][col] = @builder.get_object(imageString)
        count = count + 1
      }
    }
    #Set event handler for eventbox
    @eventbox.set_events(Gdk::Event::POINTER_MOTION_MASK)
  end

  #+++++++++++++++++++++Helper functions, not signal handlers!++++++++++++++++++++
  #Function that shows the corresponding arrow based on the value
  #stored in the global variable "col_selected"
  def show_arrow()
    #hide all arrows first
    @arrows.each { |arrow|
      arrow.hide
    }
    #Then show the one stored
    @arrows[@col_selected].show
  end

  # Method that modifies the global variable of the column selected
  # when passing the X coordinate. Called every time the mouse moves
  def set_column_selected(x)
    #get the window width
    board_width=@board.size[0]
    column_width=board_width/9
    #get the number of arrow that should be visible
    col = (x/column_width).floor-1
    if col >= 0 && col < 7
      @col_selected = col
    end
  end

  # Method for showing and activating the spinner.
  # Also pushes the message to the status bar
  # CALL THIS WHEN THE IT'S THE OPPONENT TURN!
  def activate_spinner()
    @spinner.show
    @spinner.active=true
    @boardstatusbar.push(0,"Waiting for opponent's move...")
  end

  # Method for stopping and hiding the spinner
  # CALL THIS WHEN IT IS THE PLAYER'S TURN!
  def deactivate_spinner()
    @spinner.active=false
    @spinner.hide
    @boardstatusbar.push(0,"Your turn.")
  end

  # Updates view based on array passed as parameter
  def update_board_images(modelArray)
    update_board_preconditions(modelArray)

    update_board_postconditions(modelArray)
  end

  #FOR UPDATING THE VIEW
  def update(state)
    state.grid.each_with_index { |e, row, col|
      if e == "O"
        @imageArray[row][col].set("piece_O.png")
      elsif e == "T"
        @imageArray[row][col].set("piece_T.png")
      elsif e == "R"
        @imageArray[row][col].set("piece_red.png")
      elsif e == "B"
        @imageArray[row][col].set("piece_yellow.png")
      elsif e == "G"
        @imageArray[row][col].set("piece_green.png")
      elsif e == "Y"
        @imageArray[row][col].set("piece_yellow.png")
      end
    }
  end
end

hello = MainView.new()
controller = MainController.new(hello)
hello.set_controller(controller)
hello.show