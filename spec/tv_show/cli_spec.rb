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

      @valid_argument_combos.each do |args|
        it "should accept the argument combo: '#{args.join(' ')}'" do
          expect { Cli.new(%w{Fringe} + args) }.to_not raise_error(ShowNameMissingException)
        end
      end

      it "should raise an error with just '--episode 1'" do
        expect { Cli.new %w{Fringe --episode 1} }.to raise_error(WrongArgumentOrderException)
      end

      it "should raise an error with '--title foo --episode 1'" do
        expect { Cli.new %w{Fringe --title foo --episode 1} }.to raise_error(WrongArgumentOrderException)
      end

      it "should raise an error with '--title foo --season 3 --episode 1'" do
        expect { Cli.new %w{Fringe --season 3 --title foo --episode 1} }.to raise_error(WrongArgumentOrderException)
      end
    end
  end
end
