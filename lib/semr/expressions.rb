module Semr
  module Expressions
    def word(*args)
      '(\b' + args.join('|') + '\b)'
    end
    alias :words :word
    alias :possible_words :word

    def any_word
     '(\b\w+\b)'
    end
    
    def words_in_quotes
      '\'([\w\s]+)\''
    end
  end
end