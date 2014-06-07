module Semr
  class InvalidConceptError < RuntimeError; end;
  class Phrase
    attr_reader :regex, :block

    def initialize(all_concepts, phrase, &block)
      refined_phrase = remove_optional_words(phrase)
      phrase.symbols.each do |symbol|
        if all_concepts[symbol].nil?
          raise InvalidConceptError.new("Unable to create phrase because :#{symbol} concept has not been defined.")
        else
          concept = all_concepts[symbol]
          concepts << concept
          concept_matcher = "(?<#{symbol}>#{concept.definition.to_regexp})"
          refined_phrase = refined_phrase.gsub(":#{symbol}", concept_matcher)
        end
      end
      @original = "^#{refined_phrase}"
      @regex, @block = Regexp.new(@original, :options => Regexp::IGNORECASE), block
    end

    def concepts
      @concepts ||= []
    end

    def remove_optional_words(phrase)
      phrase.gsub(/\<([\w]*)\>\s?/, '(?:\1)?\s?')
    end

    def handles?(statement)
      match = regex.match(statement)
      !match.nil?
    end

    def interpret(statement, translation)
      args = []
      statement.scan(regex) do |match|
        @concepts.each_with_index do |concept, i|
          actual_match = match[i]
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
