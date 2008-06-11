module Semr
  class Dictionary
    class << self
      def internal_dictionary
        @internal_dictionary ||= {}
      end
      
      def lookup(term)
        internal_dictionary[term] || term
      end
      
      def find_root(term)
        # TODO: Refactor
        # peoples => people
        # people => person
        # person => person DONE
        root = lookup(term)
        until root == term do
          term = root
          root = lookup(term)
        end
        root
      end
      
      def register(term, root)
        # puts "TERM: #{term}     ROOT: #{root}" if term == 'event' || root == 'event'
        internal_dictionary[term] = root
      end
    end
  end
end