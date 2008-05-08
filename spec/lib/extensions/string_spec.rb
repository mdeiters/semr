require File.dirname(__FILE__) + '/../../spec_helper'

describe String do
  
  it 'should indicate when it starts with some text' do
    'hi there'.starts_with?('hi').should be_true
    'bye now'.starts_with?('hi').should_not be_true
  end
  
  it 'should convert a string into a symbol' do
    'asdf'.symbolize.should == :asdf
    ':asdf'.symbolize.should == :asdf
  end
  
  it 'should find all occurances of symbol' do
    found_symbols = "here is a :symbol and here is :another one".symbols
    found_symbols.should have(2).symbols
    found_symbols.should include(:symbol)
    found_symbols.should include(:another)
  end
  
  it 'should convert string into a regular expression group' do
    "asdf".to_regexp.should == 'asdf'
  end
  
end
