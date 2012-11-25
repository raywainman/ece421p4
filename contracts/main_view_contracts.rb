require "test/unit"

# Contracts for the main_view class.

# Author:: Dustin Durand (dddurand@ualberta.ca)
# Author:: Kenneth Rodas (krodas@ualberta.ca)
# Author:: Raymond Wainman (wainman@uablerta.ca)
# (ECE 421 - Assignment #2)

module MainViewContracts
  include Test::Unit::Assertions
  def initialize_preconditions()
    #assert controller.is_a?(MainController), "invalid controller"
  end

  def initialize_postconditions()
    assert @imageArray != nil, "imageArray cannot be nil"
    assert @spinner1 != nil, "spinner1 cannot be nil"
    assert @entry1 != nil, "entry1 cannot be nil"
    assert @aboutdialog1 != nil, "aboutdialog1 cannot be nil"
    assert @board != nil, "board cannot be nil"
    assert @boardstatusbar != nil, "boardstatusbar cannot be nil"
    assert @eventbox1 != nil, "eventbox1 cannot be nil"
    assert @radiobutton1 != nil, "radiobutton1 cannot be nil"
    assert @radiobutton2 != nil, "radiobutton2 cannot be nil"
    assert @arrow1 != nil, "arrow1 cannot be nil"
    assert @arrow2 != nil, "arrow2 cannot be nil"
    assert @arrow3 != nil, "arrow3 cannot be nil"
    assert @arrow4 != nil, "arrow4 cannot be nil"
    assert @arrow5 != nil, "arrow5 cannot be nil"
    assert @arrow6 != nil, "arrow6 cannot be nil"
    assert @arrow7 != nil, "arrow7 cannot be nil"
  end

  def update_board_preconditions(modelArray)
  end

  def update_board_postconditions(modelArray)
  end

end