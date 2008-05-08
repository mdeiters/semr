String.class_eval do
  
  def symbols
    #TODO: Enhance to handle completely with regex
    found_symbols = []
    self.scan(/[:a-zA-Z0-9]+/).each do |match|
      found_symbols << match.symbolize if match.starts_with?(':')
    end
    found_symbols
  end
  
  def symbolize
    gsub(':', '').to_sym
  end
  
  def to_regexp
    to_s
  end
  
  def ends_with?(substr)
    self.reverse() [0..substr.length-1].reverse == substr
  end
  
  def starts_with?(substr)
    self[0..substr.length-1] == substr
  end
  alias begins_with? starts_with?
  alias start_with? starts_with?
  
end