require 'optparse'

module TvShow
  class Cli
    attr_reader :options

    def initialize(argv)
      @argv = argv
      @options = {}
      parse_options
      validate_options
    end

    def run(show_info)
      if @options[:season] && @options[:episode]
        puts show_info.name_by_episode(@options[:show], @options[:season], @options[:episode])
      elsif @options[:title] && @options[:season]
        episodes = show_info.episode_by_title(@options[:show], @options[:title], @options[:season])
        episodes.each do |ep|
          puts "#{ep[:number]}. #{ep[:name]}"
        end
      elsif @options[:season]
        episodes = show_info.list_by_season(@options[:show], @options[:season])
        episodes.each do |ep|
          puts "#{ep[:number]}. #{ep[:name]}"
        end
      elsif @options[:title]
        episodes = show_info.episode_by_title(@options[:show], @options[:title])
        episodes.each do |ep|
          puts "#{ep[:season]}.#{ep[:number]}. #{ep[:name]}"
        end
      end
    end

    private

    def parse_options
      @argv << "--help" if @argv.empty?

      OptionParser.new do |opts|
        opts.banner = "Usage: tv_show [tv show name] [options]"

        opts.on("-e", "--episode N", Integer, "Specify episode N") do |n|
          @options[:episode] = n
        end

        opts.on("-s", "--season N", Integer, "Specify season N") do |n|
          @options[:season] = n
        end

        opts.on("-t", "--title \"TITLE\"", "Specify episode TITLE") do |t|
          @options[:title] = t
        end
      end.parse!(@argv)

      @options[:show] = @argv.first
    end

    def validate_options
      raise ShowNameMissingException.new if @options[:show].nil?

      raise WrongArgumentOrderException if @options.keys.size == 2 &&
                                           @options.keys.include?(:episode)

      raise WrongArgumentOrderException if @options.keys.include?(:title) &&
                                           @options.keys.include?(:episode)
    end

  end
end
