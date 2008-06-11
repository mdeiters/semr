#support setting @instance variables in phrase blocks
module Semr
  class Language
    include Expressions
    include Normalizers
    
    class << self
      def create(grammer_file = nil, &block)
       language = Language.new
       language.instance_eval(&block) if block_given?
       language.instance_eval(IO.readlines(grammer_file).join("\n")) unless grammer_file.nil?
       language
      end
    end
    
    def concepts
     @concepts ||= {}
    end

    def phrases
     @phrases ||= []
    end

    def concept(keyword, definition, options = {})
      concepts[keyword] = Concept.new(keyword, definition, options)
    end

    def phrase(phrase, &block)
      phrases << Phrase.new(concepts, phrase, &block)
    end
    
    def parse(statement)
      translation = Translation.new
      statements = statement.split('.').map{|stmt| stmt.strip } #downcase.
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