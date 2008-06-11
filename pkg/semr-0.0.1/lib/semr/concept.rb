module Semr
  class Concept
    attr_reader :name, :definition
    
    def initialize(name, definition, options={})
      @name, @definition = name, definition
      @options = options
    end
    
    def normalize(match)
      result = arrayify(match) 
      if @options[:normalize]
        normalizers = @options[:normalize]
        normalizers = [normalizers] unless normalizers.is_a? Array
        normalizers.each do |normalizer|
          result = normalizer.call(result) 
        end
      end
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