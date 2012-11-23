require 'rubygems' 
require 'gtk2' 

class HelloGlade
   
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
  
  def get_all_widgets
    @spinner1=@builder.get_object("spinner1")
    @entry1=@builder.get_object("entry1")
    @aboutdialog1=@builder.get_object("aboutdialog1")
    @board=@builder.get_object("board")
    @boardstatusbar=@builder.get_object("statusbar2")
    @eventbox1=@builder.get_object("eventbox1")
    #Get all arrows
    @arrow1=@builder.get_object("arrow1")
    @arrow2=@builder.get_object("arrow2")
    @arrow3=@builder.get_object("arrow3")
    @arrow4=@builder.get_object("arrow4")
    @arrow5=@builder.get_object("arrow5")
    @arrow6=@builder.get_object("arrow6")
    #Set event handler for eventbox
    @eventbox1.set_events(Gdk::Event::POINTER_MOTION_MASK)
  end
  
  def initialize_vars
    #Setting max number of players
    @max_players=4
    @columns=8
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
  def show_arrow(n)
    #hide all arrows first
    @arrow1.hide
    @arrow2.hide
    @arrow3.hide
    @arrow4.hide
    @arrow5.hide
    @arrow6.hide
    #Then show the one given in n
    case n
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
    end
  end  
  
#-----------------------Click signals for buttons-----------------
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
  
  #start game button
  def on_button1_clicked
    @board.show()
  end
  
  #FOR UPDATING THE VIEW
  def update(state)
    #nothing here yet
  end
  
  #When the mouse is clicked in the board
  def on_eventbox1_button_press_event
  end 
  
  #When the mouse is moved over the board
  def on_eventbox1_motion_notify_event(widget,event)
    #get x coordinate
    x_cord=event.x
    #get the window width
    board_width=@board.size[0]
    column_width=board_width/@columns
    #get the number of arrow that should be visible
    col_number = (x_cord/column_width).floor
    #show corresponding arrow
    show_arrow(col_number)
  end
  
end

hello = HelloGlade.new
