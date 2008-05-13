module Semr
  class Concept
    attr_reader :name, :definition
    
    def initialize(name, definition, options={})
      @name, @definition = name, definition
      @options = options
    end
    
    def normalize(match)
      result = arrayify(match) 
      result = @options[:normalize].call(result) if @options[:normalize]
      result
    end
    
    def arrayify(match)
      return match if match.kind_of? String
      matches = match[1..match.end]
      matches.delete(nil)
      matches = matches.first if matches.size == 1
      matches
    end    
  end
end