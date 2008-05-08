module Semr
  class Translation
    def [] arg
      context[arg]
    end
    
    def context
      @context ||= {}
    end
    
    def phrases_translated
      @phrases_translated ||= []
    end
    
    def translated?
      !phrases_translated.empty?
    end    
  end
end
