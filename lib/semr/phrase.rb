module Semr
  class Phrase
    attr_reader :regex, :block

    def initialize(phrase, &block)
      @original = phrase
      phrase = "^#{phrase}" #match phrase from beginning
      @regex, @block = Regexp.new(phrase, Regexp::IGNORECASE), block
    end

    def handles?(statement)
      match = statement.match(regex)
      !match.nil?
    end

    def interpret(statement, translation)
      args = []
      statement.scan(regex) do |match|
        match = match.flatten.first if match.flatten.size == 1
        args << match
      end
      translation.instance_exec(*args.flatten, &block)
    end
  
    def to_regexp
      "(#{@original})"
    end
  end
end