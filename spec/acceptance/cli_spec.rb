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

  scenario "show all the episodes for season 2 of Fringe" do
    output = tv_show_exec "Fringe --season 2"
    episode_listing = [
      "1. A New Day in the Old Town",
      "2. Night of Desirable Objects",
      "3. Fracture",
      "4. Momentum Deferred",
      "5. Dream Logic",
      "6. Earthling",
      "7. Of Human Action",
      "8. August",
      "9. Snakehead",
      "10. Grey Matters",
      "11. Unearthed",
      "12. Johari Window",
      "13. What Lies Below",
      "14. The Bishop Revival",
      "15. Jacksonville",
      "16. Peter",
      "17. Olivia, in the Lab, with the Revolver",
      "18. White Tulip",
      "19. The Man from the Other Side",
      "20. Brown Betty",
      "21. Northwest Passage",
      "22. Over There (1)",
      "23. Over There (2)"
    ].each do  |line|
      output.should include(line)
    end

    $?.exitstatus.should == 0
  end

  scenario "should return episode 7 when given a title and season" do
    tv_show_exec("Fringe --season 3 --title abducted").should == "7. The Abducted\n"
    $?.exitstatus.should == 0
  end

  scenario "should return only the episodes that contain the specified title" do
    tv_show_exec("Fringe --title night").should == "1.18. Midnight\n2.2. Night of Desirable Objects\n"
    $?.exitstatus.should == 0
  end

  scenario "should allow user to choose tv show when there are various possibilities for chosen name"
  scenario "should allow user to pass API KEY via the command line"
  scenario "should allow user to specify file that contains API KEY"

  context "Non Happy Path" do
    scenario "should let user know that episode information wasn't found for wrong episode" do
      pending
      output = tv_show_exec "Fringe --season 1 --episode 30"
      output.should include("No episode information found")

      $?.exitstatus.should == 0
    end

    scenario "should let user know that episode information wasn't found for wrong season"
    scenario "should let user know that tv show name wasn't found"
  end

end
