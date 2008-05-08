#support setting @instance variables in phrase blocks
module Semr
  class InvalidConceptError < RuntimeError; end;
  class Language
    include Expressions    
    class << self
      def create(&block)
       language = Language.new
       language.instance_eval(&block)
       language
      end
    end
    
    def concepts
     @concepts ||= {}
    end

    def phrases
     @phrases ||= []
    end

    def concept(keyword, definition)
     concepts[keyword] = definition
    end

    def phrase(phrase, &block)
     refined_phrase = phrase.dup
     refined_phrase = refined_phrase.gsub(/\<([\w]*)\>\s?/, '(?:\1)?\s?') #ignores optional words
     phrase.symbols.each do |symbol|
       if concepts[symbol].nil?
         raise InvalidConceptError.new("#{symbol} is not a valid concept.") 
       end
       refined_phrase = refined_phrase.gsub(":#{symbol}", concepts[symbol].to_regexp )
     end
     phrases << Phrase.new(refined_phrase, &block)
     phrase
    end
    
    def parse(statement)
      translation = Translation.new
      statements = statement.split('.').map{|stmt| stmt.strip}
      statements.each do |statement|
        phrases.each do |phrase|
          if phrase.handles?(statement)
            translation.phrases_translated << phrase
            phrase.interpret(statement, translation)
            break #break loop and process next statement
          end
        end
      end
      translation
    end
  end
end