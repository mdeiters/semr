module Semr
  class Phrase
    attr_reader :regex, :block

    def initialize(concepts, phrase, &block)
      @concepts = concepts
      @original = phrase
      phrase = "^#{phrase}" #match phrase from beginning..$
      #@regex, @block = Regexp.new(phrase, Regexp::IGNORECASE), block
      @regex, @block = Oniguruma::ORegexp.new(phrase, :options => Oniguruma::OPTION_IGNORECASE), block      
    end

    def handles?(statement)
      match = regex.match(statement) 
      !match.nil?
    end

    def interpret(statement, translation)
      args = []
      regex.scan(statement) do |match|
        @concepts.each do |concept|
          actual_match = match[concept.name]
          args << concept.normalize(actual_match)
        end
      end
      # args = args.first if args.size == 1
      translation.instance_exec(*args, &block)
    end
    
    def debug(match)
      matches = match[0..match.end]
      matches.each do |match|
        puts match
        puts ' ---- '
      end
    end
    
    def to_regexp
      "(#{@original})"
    end
  end
end
# module Semr
#   class Phrase
#     attr_reader :regex, :block
# 
#     def initialize(phrase, &block)
#       @original = phrase
#       phrase = "^#{phrase}" #match phrase from beginning..$
#       #@regex, @block = Regexp.new(phrase, Regexp::IGNORECASE), block
#       @regex, @block = Oniguruma::ORegexp.new(phrase, :options => Oniguruma::OPTION_IGNORECASE), block      
#     end
# 
#     def handles?(statement)
#       match = statement.match(regex)
#       !match.nil?
#     end
# 
#     def interpret(statement, translation)
#       args = []
#       statement.scan(regex) do |match|        
#         match = match.flatten.first if match.flatten.size == 1
#         match.delete(nil) if match.kind_of?(Array)
#         args << match
#       end
#       # puts args.inspect
#       translation.instance_exec(*args.flatten, &block)
#     end
#   
#     def to_regexp
#       "(#{@original})"
#     end
#   end
# end