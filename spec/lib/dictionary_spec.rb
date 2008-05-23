require File.dirname(__FILE__) + '/../spec_helper'

module Semr
  describe Dictionary do
  
    it 'should find roots' do
      Dictionary.register('people', 'person')
      Dictionary.find_root('people').should == 'person'
      
      Dictionary.register('peoples', 'people')
      Dictionary.find_root('peoples').should == 'person'
      
      Dictionary.find_root('person').should == 'person'
    end
    
    it 'should return self if no root foudn' do
      Dictionary.find_root('not defined').should == 'not defined'
    end
  
  end
end