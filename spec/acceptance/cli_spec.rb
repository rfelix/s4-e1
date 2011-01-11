require File.join(File.dirname(__FILE__), 'acceptance_helper.rb')

feature "tv_show CLI" do

  scenario "should show help when no arguments passed" do
    output = tv_show_exec
    output.should include "tv_show help:"
  end

  #scenario "should return Firefly for episode 10 of Fringe season 3" do
  #  0.should == 1
  #end
end
