require 'rubygems' 
require 'gtk2' 

class HelloGlade
   
  attr :glade
   
  def initialize  
      Gtk.init 
      builder = Gtk::Builder::new
      builder.add_from_file("tutorial.glade") 
      builder.connect_signals{ |handler| method(handler) } 
      window = builder.get_object("mainMenu") 
      window.show() 
      Gtk.main() 
  end
  
  def on_button1_clicked(widget)
    puts "hello world"
  end
  
  def on_button2_clicked(widget)
    exit(0)
  end
  
  def on_imagemenuitem1_activate_item(widget)
    exit(0)
  end
  
  def on_checkbutton1_toggled(widget)
    textview1.text="res"
  end
 
end
hello = HelloGlade.new
