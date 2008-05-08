begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'semr'
require 'rubygems'
require 'mocha'

Spec::Runner.configure do |config|
  config.mock_with :mocha  
end
