module Semr
  module Normalizers
    def by_removing_outer_quotes
      proc { |value| value.gsub("'", "") }
    end
    
    def as_class
      proc { |value| value.classify.constanize }
    end
    
    def as_fixnum
      proc { |value| value.to_i }
    end
    
    def as_list
      proc { |value| value.split(/,|and/).map{|item| item.strip} }
    end
  end
end