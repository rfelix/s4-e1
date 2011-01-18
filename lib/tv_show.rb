require 'rubygems'
require 'bundler/setup'
Bundler.require

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__)))
$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), '..', 'vendor'))

module TvShow
  require 'tv_show/exceptions'
  require 'tv_show/cli'
  require 'tv_show/tv_db_show_info'
	require 'tv_show/tv_db_api'
end
