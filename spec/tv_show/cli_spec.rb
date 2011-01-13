require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

module TvShow
  describe Cli do
    context "Arguments" do
      it "should define options for episode and season" do
        cli = Cli.new(%w{Fringe --season 3 --episode 2})

        cli.options[:show].should == "Fringe"
        cli.options[:season].should  == 3
        cli.options[:episode].should == 2
      end

      it "should define options for episode title" do
        cli = Cli.new(%w{Fringe --title} + ["Northwest Passage"])

        cli.options[:show].should == "Fringe"
        cli.options[:title].should == "Northwest Passage"
      end
    end

    context "Argument Validations" do
      it "should give an error when show name is not specified" do
        expect { Cli.new(%w{--season 3 --episode 2}) }.to raise_error(ShowNameMissingException)
      end

      @valid_argument_combos = [
        %w{--season 3},
        %w{--title foo},
        %w{--season 3 --title foo},
        %w{--season 3 --episode 1}
      ]

      it "should accept just the season argument"
      it "should accept just the title argument"
      it "should accept the season and title argument combo"
      it "should accept the season and episode argument combo"
      it "should raise an error with the rest of the argument combos"
    end
  end
end
