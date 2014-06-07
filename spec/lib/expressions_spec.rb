require 'spec_helper'

module Semr
  describe Expressions do
    include Expressions

    it 'matches known words' do
      known_words = word('one', 'two')
      result = scan('here is one and here is two').for(known_words)
      result.first[0].should == 'one'
      result.last[0].should == 'two'
    end

    it 'matches any word' do
      result = scan('some text').for("some #{any_word}")
      result[0].should == 'text'
    end

    it 'matches any number' do
      scan('some number 0').for("some number #{any_number}")[0].should == '0'
      scan('some number 883').for("some number #{any_number}")[0].should == '883'
    end

    it 'matches words in quotes' do
      scan("find 'this text'").for("find #{words_in_quotes}")[0].should == 'this text'
    end

    it 'matches multiple occurrences of word separated by commas and seperated by and' do
      find = multiple_occurrences_of('one', 'two', 'three')
      results = scan("find one, two and three").for("find #{find}")
      results[0].should == 'one'
      results[1].should == 'two'
      results[2].should == 'three'

      find = "^find #{multiple_occurrences_of('events', 'users', 'three')}"
      results = scan("find events and users").for(find)
      results[0].should == 'events'
      results[1].should == 'users'

      results = scan("find users and events").for(find)
      results[0].should == 'events'
      results[1].should == 'users'
    end

    it 'finds all occurances of active record models using ModelInflector' do
      Rails::ModelInflector.expects(:all).returns(:model_names)
      all_models.should == :model_names
    end


    it 'trys' do
      # r = '(?i-mx)^(?<action>(\w+)) (?<list>(?:(?:\s|,|and)|(\bone)|(\btwo)|(\bthree)|(\bfour))*) to context'
      # r = '(?i-mx)^(?<action>(\w+)) (((?<list>one)|(?<list>two)|(?<list>three)|(?<list>four))*) to context'
      # r = '(?i-mx)^(?<action>(\w+)) ((?:\s|,|and)|(?<list>one)|(?<list>two)|(?<list>three)|(?<list4>four))* to context'
      # r = '(?i-mx)^(?<action>(\w+)) (?<list>(?:\s|,|and)|(one|two|three|four))* to context'
      r = '(?i-mx)^(?<action>(\w+)) (?<list>(?:(?:\s|,|and)|(\bone)|(\btwo)|(\bthree)|(\bfour))*) to context'

      match = scan('add one two three to context').for(r)
      # puts match[:list]
      loopall match
    end

    def loopall(match)
      match.each_with_index do |_, m|
        puts "<BR>"
        puts m
      end
    end


  end
end
