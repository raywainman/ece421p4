require 'rubygems' 
require 'gtk2' 

class HelloGlade
   
 
  
  def initialize  
      Gtk.init 
      @builder = Gtk::Builder::new
      @builder.add_from_file("tutorial.glade") 
      @builder.connect_signals{ |handler| method(handler) } 
      window = @builder.get_object("mainMenu")
      self.get_all_objects() 
      window.show() 
      Gtk.main()
      @spinner_activated=false
  end
  
  def get_all_objects
    @spinner1=@builder.get_object("spinner1")
  end
  
  def on_button2_clicked(widget)
    Gtk.main_quit
  end
  
  def on_spinbutton1_change_value(widget)
    #nothing
  end
  
  def on_button1_clicked(widget)
    @spinner_activated=!@spinner_activated
    @spinner1.active=@spinner_activated
  end
  
  def on_button3_clicked
    @spinner1.visible=false
    puts "hidden"
  end
 
end
hello = HelloGlade.new
