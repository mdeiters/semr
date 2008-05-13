module Semr
  module Rails
    class ModelInflector
      class << self
        def all
          ModelInflector.new ::ActiveRecord::Base.send(:subclasses)          
        end
      end
      
      attr_reader :models, :inflections
      
      def initialize(models)
        @models = models
        @inflections = models.collect{|klass| klass.name.to_s }
      end 
      
      def with_plurals
        plural_inflections = []
        @inflections.each do |inflection|
          plural_inflections << inflection.pluralize
        end
        @inflections.unshift plural_inflections
        #@inflections << plural_inflections - need to test, plurals screws up regex
        @inflections.flatten!
        self
      end
      
      def with_synonyms
        @models.each do |model|
          @inflections << model.synonyms unless model.synonyms.nil? || model.synonyms.empty?
        end
        @inflections.flatten!
        self
      end
      
      def and
        self
      end
      
      def to_a
        @inflections
      end
    end
  end
end

# require 'find'      
#     Find.find("#{RAILS_ROOT}/app/models/") do |path|
#       require path if File.exist?(path) && !File.directory?(path) && File.rb?(path)
#     end      
#   end
# 
#   class File
#     def File.rb?(path)
#       path.split('.').last == 'rb'
#     end
#   end    
#   
