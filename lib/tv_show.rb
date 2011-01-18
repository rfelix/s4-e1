require 'rubygems'
require 'bundler/setup'
Bundler.require

require 'tv_show/cli'
require 'tv_show/tv_db_show_info'
require 'tv_show/tv_db_api'

module TvShow
  TvShowError             = Class.new(StandardError)
  ShowNameMissingError    = Class.new(TvShowError)
  WrongArgumentOrderError = Class.new(TvShowError)
end
