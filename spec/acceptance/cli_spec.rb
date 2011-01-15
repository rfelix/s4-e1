require File.join(File.dirname(__FILE__), 'acceptance_helper.rb')

feature "tv_show CLI", :acceptance => true do

  scenario "should show help when no arguments passed" do
    output = tv_show_exec
    help_topics = [
      "Usage: tv_show [tv show name] [options]",
      "--season",
      "--episode",
      "--title"
    ]
    help_topics.each { |topic| output.should include(topic) }

    $?.exitstatus.should == 0
  end

  scenario "should return Firefly for episode 10 of Fringe season 3" do
    tv_show_exec("Fringe --season 3 --episode 10").should == "Firefly\n"
    $?.exitstatus.should == 0
  end

end
