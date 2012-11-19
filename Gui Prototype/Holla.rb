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
      window.show() 
      Gtk.main()
      @spinner_activated=false
  end
  
  def get_all_widgets
    @spinner1=@builder.get_object("spinner1")
    @entry1=@builder.get_object("entry1")
  end
  
  def gtk_main_quit
    Gtk.main_quit
  end
  
  def on_imagemenuitem10_activate
    aboutdialog1=@builder.get_object("aboutdialog1")
    aboutdialog1.show()
  end
  
#--------Click signals for all buttons------
  def on_button3_clicked
    @spinner1.visible=false
    puts "hidden"
  end
  
  def on_button4_clicked
    text=Integer(@entry1.text)
    if text<4
      @entry1.text=(text+1).to_s()
    end
  end
  
  def on_button5_clicked
    text=Integer(@entry1.text)
    if text>1
      @entry1.text=(text-1).to_s()
    end
  end
 
end

hello = HelloGlade.new
