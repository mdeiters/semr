module Semr
  module Rails
    module ModelSynonym
      def human_synonyms *synonyms
        @synonyms = synonyms
      end
      def synonyms
        @synonyms ||= []
      end
    end
  end
end