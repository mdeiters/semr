module Semr
  module Rails
    class ModelInflector
      class << self
        def all
          ModelInflector.new ::ActiveRecord::Base.descendants
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
          root = Dictionary.find_root(inflection)
          pluralized_inflection = inflection.pluralize
          Dictionary.register(pluralized_inflection, root)
          plural_inflections << pluralized_inflection
        end
        @inflections.unshift plural_inflections
        #@inflections << plural_inflections - need to test, plurals screws up regex
        @inflections.flatten!
        self
      end

      def with_synonyms
        @models.each do |model|
          model.synonyms.each do |synonym|
            Dictionary.register(synonym, model.name)
            @inflections << synonym
          end unless model.synonyms.nil? || model.synonyms.empty?
        end
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
