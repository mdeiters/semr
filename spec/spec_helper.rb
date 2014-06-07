require 'bundler/setup'

Bundler.setup

require 'active_record'
require 'active_support'
require 'semr'
require 'pry'

RSpec.configure do |config|
  config.mock_framework = :mocha
end

def create_regex(expression)
  Regexp.new(expression)
end

def scan(string)
  Scanner.new(string)
end

class Scanner
  def initialize(string)
    @string = string
  end

  def for(expression)
    regexp = Regexp.new(expression)
    matches = []
    @string.scan(regexp) do |match|
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
