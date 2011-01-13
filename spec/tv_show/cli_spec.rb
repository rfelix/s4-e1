require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

module TvShow
  describe Cli do
    context "Valid Arguments" do
      it "should accept the argument '--season 3'" do
        cli = nil
        expect {
          cli = Cli.new(%w{Fringe --season 3})
        }.to_not raise_error(ShowNameMissingException)

        cli.options[:show].should == "Fringe"
        cli.options[:season].should == 3
      end

      it "should accept the argument '--title northwest'" do
        cli = nil
        expect {
          cli = Cli.new(%w{Fringe --title northwest})
        }.to_not raise_error(ShowNameMissingException)

        cli.options[:show].should == "Fringe"
        cli.options[:title].should == "northwest"
      end

      it "should accept the argument '--season 3 --title northwest'" do
        cli = nil
        expect {
          cli = Cli.new(%w{Fringe --season 3 --title northwest})
        }.to_not raise_error(ShowNameMissingException)

        cli.options[:show].should == "Fringe"
        cli.options[:season].should == 3
        cli.options[:title].should == "northwest"
      end

      it "should accept the argument '--season 3 --episode 1'" do
        cli = nil
        expect {
          cli = Cli.new(%w{Fringe --season 3 --episode 1})
        }.to_not raise_error(ShowNameMissingException)

        cli.options[:show].should == "Fringe"
        cli.options[:season].should == 3
        cli.options[:episode].should == 1
      end
    end

    context "Invalid Arguments" do
      it "should give an error when show name is not specified" do
        expect { Cli.new(%w{--season 3 --episode 2}) }.to raise_error(ShowNameMissingException)
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
