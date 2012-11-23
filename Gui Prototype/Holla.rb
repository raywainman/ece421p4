require 'rubygems' 
require 'gtk2' 

class HelloGlade
   
  #Constructor
  #Initializes GUI via .glade file and gets all the widgets via "get_all_widgets"  
  def initialize  
      Gtk.init 
      @builder = Gtk::Builder::new
      @builder.add_from_file("tutorial.glade") 
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
    @image1=@builder.get_object("image1")
    @boardstatusbar=@builder.get_object("statusbar2")
  end
  
  def initialize_vars
    #Setting max number of players
    @max_players=4
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
  
#--------Click signals for buttons------
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
  
  def on_button2_enter
    @boardstatusbar.push(0,"lol")
  end
 
end

hello = HelloGlade.new
