begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

require 'rubygems'
require 'oniguruma' #http://oniguruma.rubyforge.org
require 'mocha'
require 'active_record'
require 'active_support'

Spec::Runner.configure do |config|
  config.mock_with :mocha  
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'semr'


def create_regex(expression)
  Oniguruma::ORegexp.new(expression)
end

def scan(string)
  Scanner.new(string)
end

class Scanner
  def initialize(string)
    @string = string
  end
  
  def for(expression)
    regexp = Oniguruma::ORegexp.new(expression)
    matches = []
    regexp.scan(@string) do |match|
      if block_given?
        yield match
      else
        matches << match        
      end
    end
    unless block_given?
      matches = matches.first if matches.size == 1
      matches
    end
  end
end