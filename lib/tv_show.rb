require 'rubygems'
require 'bundler/setup'
Bundler.require

module TvShow
  class ShowNameMissingException < Exception; end
  class WrongArgumentOrderException < Exception; end

  require 'tv_show/cli'
end
