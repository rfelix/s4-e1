require 'httparty'
require 'httparty_icebox'
require 'uri'

module TvShow
  module TvDb
    class Client
      include HTTParty
      include HTTParty::Icebox

      def initialize(api_key, cache_dir = nil)
        @base_url     = "http://thetvdb.com/api"
        @base_api_url = "#{@base_url}/#{api_key}"

        cache_dir ||= File.join(File.dirname(__FILE__),'..', '..', 'cache')
        self.class.cache :store    => 'file',
          :timeout  => 600,
          :location => cache_dir
      end

      def show_id(show_name)
        show_name = URI.escape show_name
        resp = get("/GetSeries.php?seriesname=#{show_name}", false)
        # TODO: This can have more than one tv series id
        resp.parsed_response['Data']['Series']['id']
      end

      def show_info(options = {})
        raise ArgumentError, "options needs :id, :episode, and :season" if !options.include?(:id)     &&
                                                                           !options.include?(:season) &&
                                                                           !options.include?(:episode)

        resp = get("/series/#{options[:id]}/default/#{options[:season]}/#{options[:episode]}")
        if resp.code == 404
          { 'EpisodeName' => '' }
        else
          resp.parsed_response['Data']['Episode']
        end
      end

      def season_info(show_id, season_num)
        resp = get("/series/#{show_id}/all/en.xml")
        structure_season_info(resp.parsed_response)
      end

      private

      def get(url, use_api = true)
        url << '/' unless url =~ /^\//
          base_url = use_api ? @base_api_url : @base_url
        self.class.get "#{base_url}#{url}"
      end

      def structure_season_info(parsed_response)
        structured = {}
        parsed_response['Data']['Episode'].each do |episode_info|
          season_info  = structured["Season#{episode_info['SeasonNumber']}"] ||= []
          season_info << {
            "EpisodeName"   => episode_info['EpisodeName'],
            "EpisodeNumber" => episode_info['EpisodeNumber'],
            "SeasonNumber"  => episode_info['SeasonNumber']
          }
        end
        structured
      end
    end

  end
end
