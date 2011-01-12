require 'optparse'

module TvShow
  class Cli
    attr_reader :options

    def initialize(argv)
      @argv = argv
      @options = {}
      parse_options
    end

    def run
    end

    private

    def parse_options
      @argv << "--help" if @argv.empty?

      OptionParser.new do |opts|
        opts.banner = "Usage: tv_show [tv show name] [options]"

        opts.on("-e", "--episode N", Integer, "Specify episode N") do |n|
        end

        opts.on("-s", "--season N", Integer, "Specify season N") do |n|
        end

        opts.on("-t", "--title \"TITLE\"", "Specify episode TITLE") do |t|
        end
      end.parse!(@argv)
    end
  end
end
