require File.dirname(__FILE__) + '/../../spec_helper'

module Semr
  module Rails
    describe ModelInflector do
      class ::Person < ActiveRecord::Base; end;
      class ::Event < ActiveRecord::Base; end;

      it 'finds all occurrences of active record models' do
        ModelInflector.all.inflections.should include('Person')
        ModelInflector.all.inflections.should include('Event')
      end    

      it 'pluralizes occurrence models' do
        ModelInflector.all.with_plurals.inflections.should include('People')
        ModelInflector.all.with_plurals.inflections.should include('Events')        
      end
      
      it 'adds a models human alias to inflections' do
        Person.class_eval do
          human_synonyms 'Friend', 'Relative'
        end
        Event.class_eval do
          human_synonyms 'Special Day'
        end
        ModelInflector.all.with_synonyms.inflections.should include('Friend')
        ModelInflector.all.with_synonyms.inflections.should include('Special Day')
        ModelInflector.all.with_synonyms.and.with_plurals.inflections.should include('Relatives')      
      end

      it 'should support human names for namespaced models' do
        pending 
      end
      
    end
  end
end