module Semr
  module Normalizers
    def by_removing_outer_quotes
      proc { |value| value.gsub("'", "") }
    end
    
    def as_class
      proc { |value| value.classify.constantize }
    end
    
    def as_fixnum
      proc { |value| value.to_i }
    end
    
    def as_list
      proc { |value| value.split(/,|and/).map{|item| item.strip} }
    end
    
    def as_list_of_classes
      proc { |value| value.split(/,|and/).map{|item| item.strip.classify.constantize } }
    end
    
  end
end