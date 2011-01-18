$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), '..', 'vendor'))

require 'rspec'
require 'tv_show'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
