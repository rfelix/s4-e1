require 'optparse'

module TvShow
  class Cli
    attr_reader :options

    def initialize(argv)
      @argv = argv
      @options = {}
    end

    def run(api_key)
      parse_options
      validate_options

      @show_info = TvShow::TvDb::ShowInfo.new(
        @options[:show],
        TvShow::TvDb::Client.new(api_key)
      )

      info_by_season_and_episode ||
      info_by_season_and_title   ||
      info_by_season             ||
      info_by_title

    rescue SocketError
      puts "Error: Connection to web service failed"
      -1 # Error status
    rescue TvShowError => e
      puts "Error: #{e}"
      -2
    rescue OptionParser::ParseError => p
      puts "Error: #{p}"
      -3
    end

    private

    def info_by_season_and_episode
      return unless @options[:season] && @options[:episode]
      puts @show_info.name_by_episode(@options[:season], @options[:episode])
      0
    end

    def info_by_season_and_title
      return unless @options[:title] && @options[:season]
      episodes = @show_info.episode_by_title(@options[:title], @options[:season])
      episodes.each do |ep|
        puts "#{ep[:number]}. #{ep[:name]}"
      end
      0
    end

    def info_by_season
      return unless @options[:season]
      episodes = @show_info.list_by_season(@options[:season])
      episodes.each do |ep|
        puts "#{ep[:number]}. #{ep[:name]}"
      end
      0
    end

    def info_by_title
      return unless @options[:title]
      episodes = @show_info.episode_by_title(@options[:title])
      episodes.each do |ep|
        puts "#{ep[:season]}.#{ep[:number]}. #{ep[:name]}"
      end
      0
    end

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
      if @options[:show].nil?
        raise ShowNameMissingError, "TV Show name is missing"
      elsif (@options.keys.size == 2        && @options.keys.include?(:episode)) ||
            (@options.keys.include?(:title) && @options.keys.include?(:episode))
        raise WrongArgumentOrderError, "Specified arguments are in wrong order"
      end
    end
  end
end
