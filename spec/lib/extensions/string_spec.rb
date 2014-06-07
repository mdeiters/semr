require 'spec_helper'

describe String do

  it 'should indicate when it starts with some text' do
    expect('hi there').to start_with('hi')
    expect('bye now').to_not start_with('hi')
  end

  it 'should convert a string into a symbol' do
    expect('asdf'.symbolize).to eq :asdf
    expect(':asdf'.symbolize).to eq :asdf
  end

  it 'should find all occurances of symbol' do
    found_symbols = "here is a :symbol and here is :another one".symbols
    expect(found_symbols.length).to eq 2
    expect(found_symbols).to include(:symbol)
    expect(found_symbols).to include(:another)
  end

  it 'should convert string into a regular expression group' do
    expect("asdf".to_regexp).to eq 'asdf'
  end

end
