require_relative "./main_controller"
require_relative "./main_view"

# Author:: Dustin Durand (dddurand@ualberta.ca)
# Author:: Kenneth Rodas (krodas@ualberta.ca)
# Author:: Raymond Wainman (wainman@uablerta.ca)
# (ECE 421 - Assignment #4)

# Assignment 4 main file, simply creates an instance of the GUI and its
# controller object and binds them together.

# To run, simply run the following command:
# ruby assignment4.rb

view = MainView.new()
controller = MainController.new(view)
view.set_controller(controller)
view.show