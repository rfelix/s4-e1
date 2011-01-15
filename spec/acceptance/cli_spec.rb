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

end
