require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')
require 'stringio'


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

    context "Execution" do
      it "should get information by season and episode" do
        the_tv_db = double('TheTvDb')
        the_tv_db.should_receive(:name_by_episode).with("Fringe", 3, 10).and_return("Firefly")
        suspend_output do
          Cli.new(%w{Fringe --season 3 --episode 10}).run(the_tv_db)
        end
      end

      it "should get information by season" do
        the_tv_db = double('TheTvDb')
        the_tv_db.should_receive(:list_by_season).with("Fringe", 3).and_return([{
          :name => 'Firefly',
          :number => '10'
        }])

        Cli.new(%w{Fringe --season 3}).run(the_tv_db)
      end

      it "should get information by title" do
        the_tv_db = double('TheTvDb')
        the_tv_db.should_receive(:episode_by_title).with("Fringe", 'northwest').and_return([{
          :name => 'Northwest Passage',
          :number => '21',
          :season => '2'
        }])

        Cli.new(%w{Fringe --title northwest}).run(the_tv_db)
      end

      it "should get information by title and season" do
        the_tv_db = double('TheTvDb')
        the_tv_db.should_receive(:episode_by_title).with("Fringe", 'northwest', 3).and_return([{
          :name => 'Northwest Passage',
          :number => '21'
        }])

        Cli.new(%w{Fringe --title northwest --season 3}).run(the_tv_db)
      end

    end

  end
end
