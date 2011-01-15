require 'httparty'
require 'icebox'
require 'uri'

module TvShow
  class TvDbApi
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

    def show_id_for(show_name)
      show_name = URI.escape show_name
      resp = get("/GetSeries.php?seriesname=#{show_name}", false)
      resp.parsed_response['Data']['Series']['id']
    end

    def show_info_for(show_id, season_num, episode_num)
      resp = get("/series/#{show_id}/default/#{season_num}/#{episode_num}")
      resp.parsed_response
    end

    private

    def get(url, use_api = true)
      url << '/' unless url =~ /^\//
      base_url = use_api ? @base_api_url : @base_url
      self.class.get "#{base_url}#{url}"
    end
  end
end
