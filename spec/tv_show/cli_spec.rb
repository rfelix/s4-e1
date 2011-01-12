require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

module TvShow
  describe Cli do
    it "should define options for episode and season" do
      cli = Cli.new(["--season 3 --episode 2"])
      cli.options[:season].should  == 3
      cli.options[:episode].should == 2
    end
  end
end
