require 'rubygems' 
require 'gtk2' 
require './contracts/view_update_contracts'

# User interface for the connect4/otto game

# Author:: Dustin Durand (dddurand@ualberta.ca)
# Author:: Kenneth Rodas (krodas@ualberta.ca)
# Author:: Raymond Wainman (wainman@uablerta.ca)
# (ECE 421 - Assignment #4)

class HelloGlade
   include View_update_contracts
  #Constructor
  #Initializes GUI via .glade file and gets all the widgets via "get_all_widgets"  
  def initialize  
      Gtk.init 
      @builder = Gtk::Builder::new
      @builder.add_from_file("GUI.glade") 
      @builder.connect_signals{ |handler| method(handler) } 
      window = @builder.get_object("mainMenu")
      self.get_all_widgets()
      self.initialize_vars() 
      window.show() 
      Gtk.main()
  end
  
  #Method called from constructor to get all the widgets 
  #into useful objects.
  def get_all_widgets
    #Get all miscellaneous widgets
    @spinner1=@builder.get_object("spinner1")
    @entry1=@builder.get_object("entry1")
    @aboutdialog1=@builder.get_object("aboutdialog1")
    @board=@builder.get_object("board")
    @boardstatusbar=@builder.get_object("statusbar2")
    @eventbox1=@builder.get_object("eventbox1")
    @radiobutton1=@builder.get_object("radiobutton1")
    @radiobutton2=@builder.get_object("radiobutton2")
    #Get all arrows
    @arrow1=@builder.get_object("arrow1")
    @arrow2=@builder.get_object("arrow2")
    @arrow3=@builder.get_object("arrow3")
    @arrow4=@builder.get_object("arrow4")
    @arrow5=@builder.get_object("arrow5")
    @arrow6=@builder.get_object("arrow6")
    @arrow7=@builder.get_object("arrow7")
    #Get all images
    @imageArray=Array.new(43)
    (1..42).each do |i|
      imageString = "image" + i.to_s()
      @imageArray[i]=@builder.get_object(imageString)
    end
    #Set event handler for eventbox
    @eventbox1.set_events(Gdk::Event::POINTER_MOTION_MASK)
  end
  
  #Initializing all global vars
  def initialize_vars
    @max_players=4
    @columns=9
    @col_selected=0
    @test=1
    @game_mode=nil
  end
  
  #Generic method for quitting application
  def gtk_main_quit
    #add methods to tidy up here
    Gtk.main_quit
  end
  
  #Show the about dialog when Help->About is clicked
  def on_imagemenuitem10_activate
    @aboutdialog1.show()
  end
  
  def on_aboutdialog1_close
    @aboutdialog1.hide()
  end
  
#+++++++++++++++++++++Helper functions, not signal handlers!++++++++++++++++++++
  #Function that shows the corresponding arrow based on the value
  #stored in the global variable "col_number"
  def show_arrow()
    #hide all arrows first
    @arrow1.hide
    @arrow2.hide
    @arrow3.hide
    @arrow4.hide
    @arrow5.hide
    @arrow6.hide
    @arrow7.hide
    #Then show the one stored
    case @col_selected
    when 1
      @arrow1.show
    when 2
      @arrow2.show
    when 3
      @arrow3.show
    when 4
      @arrow4.show
    when 5
      @arrow5.show
    when 6
      @arrow6.show
    when 7
      @arrow7.show
    end
  end 
  
  #Method that modifies the global variable of the column selected
  #when passing the X coordinate. Called everytime the mouse moves
  def set_column_selected(x)
     #get the window width
     board_width=@board.size[0]
     column_width=board_width/@columns
     #get the number of arrow that should be visible
     @col_selected = (x/column_width).floor
  end 
  
  #Method for showing and activating the spinner.
  #Also pushes the message to the status bar
  def activate_spinner()
    @spinner1.show
    @spinner1.active=true
    @boardstatusbar.push(0,"Waiting for opponent's move...")
  end
  
  #Method for stopping and hiding the spinner
  def deactivate_spinner()
    @spinner1.active=false
    @spinner1.hide
    @boardstatusbar.push(0,"Your turn.")
  end
  
  #Updates view based on array passed as parametre
  def update_board_images(modelArray)
    update_board_preconditions(modelArray)
    
    update_board_postconditions(modelArray)
  end
  
#-------------------------------Signal handlers--------------------------------------
  #PLUS button
  def on_button4_clicked
    text=Integer(@entry1.text)
    if (text<@max_players)
      @entry1.text=(text+1).to_s()
    end
  end
  
  #MINUS button
  def on_button5_clicked
    text=Integer(@entry1.text)
    if text>1
      @entry1.text=(text-1).to_s()
    end
  end
  
  #Starts the game by saving the game mode in @game_mode
  #as a string, and shows the window where the board is.
  def on_button1_clicked
    #Set game type based on radio buttons
    if @radiobutton1.active?
      @game_mode="Connect4"
    else
      @game_mode="OTTO"
    end
    #Then show the board
    @board.title=@game_mode+" Playing Area"
    @board.show()
  end
  
  #FOR UPDATING THE VIEW
  def update(state)
    #nothing here yet
    #update_board_images(state.array)
  end
  
  #When the mouse is clicked inside the board. Here is where
  #the state object is sent to the model
  def on_eventbox1_button_release_event
    if @col_selected>0 and @col_selected<(@columns-1)
      
      if @test.odd?
        activate_spinner()
        @imageArray[@test].set("piece_T.png")
        else
        deactivate_spinner()
        @imageArray[@test].set("piece_O.png")
      end     
      @test=@test+1
      
    end
    
  end 
  
  #When the mouse is moved over the board
  def on_eventbox1_motion_notify_event(widget,event)
    #get the column
    set_column_selected(event.x)   
    #show corresponding arrow
    show_arrow()
  end
  
end

hello = HelloGlade.new
