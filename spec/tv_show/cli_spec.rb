require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

module TvShow
  describe Cli do
    context "Valid Arguments" do
      it "should accept the argument '--season 3'" do
        cli = nil
        expect {
          cli = Cli.new(%w{Fringe --season 3})
          cli.run("")
        }.to_not raise_error(ShowNameMissingError)

        cli.options[:show].should == "Fringe"
        cli.options[:season].should == 3
      end

      it "should accept the argument '--title northwest'" do
        cli = nil
        expect {
          cli = Cli.new(%w{Fringe --title northwest})
          cli.run("")
        }.to_not raise_error(ShowNameMissingError)

        cli.options[:show].should == "Fringe"
        cli.options[:title].should == "northwest"
      end

      it "should accept the argument '--season 3 --title northwest'" do
        cli = nil
        expect {
          cli = Cli.new(%w{Fringe --season 3 --title northwest})
          cli.run("")
        }.to_not raise_error(ShowNameMissingError)

        cli.options[:show].should == "Fringe"
        cli.options[:season].should == 3
        cli.options[:title].should == "northwest"
      end

      it "should accept the argument '--season 3 --episode 1'" do
        cli = nil
        expect {
          cli = Cli.new(%w{Fringe --season 3 --episode 1})
          cli.run("")
        }.to_not raise_error(ShowNameMissingError)

        cli.options[:show].should == "Fringe"
        cli.options[:season].should == 3
        cli.options[:episode].should == 1
      end
    end

    context "Invalid Arguments" do
      it "should give an error when show name is not specified" do
        status = Cli.new(%w{--season 3 --episode 2}).run("")
        status.should == -2
      end

      it "should raise an error with just '--episode 1'" do
        status = Cli.new(%w{Fringe --episode 1}).run("")
        status.should == -2
      end

      it "should raise an error with '--title foo --episode 1'" do
        status = Cli.new(%w{Fringe --title foo --episode 1}).run("")
        status.should == -2
      end

      it "should raise an error with '--title foo --season 3 --episode 1'" do
        status = Cli.new(%w{Fringe --season 3 --title foo --episode 1}).run("")
        status.should == -2
      end
    end

    context "Errors" do
      it "should give an error when there is no internet connection" do
        # Make as if HTTParty returned a SocketError
        class TvShow::TvDb::Client
          alias_method :old_get, :get
          def get(url, use_api = true)
            raise SocketError
          end
        end

        status = Cli.new(%w{Fringe --season 3 --episode 10}).run("API KEY")

        TvShow::TvDb::Client.send :alias_method, :get, :old_get

        status.should == -1
      end
    end

  end
end
