require File.dirname(__FILE__) + '/../spec_helper'

module Semr
  describe Language do
    
    it 'supports word concepts' do
      language = Language.create do |language|
        concept :word, any_word
        phrase 'feature :word' do |word|
          word
        end      
      end    
      language.parse("feature documents")[:result] == 'documents'
    end
  
    it 'supports multiple word concepts' do
      language = Language.create do |language|
        concept :subject, word('first person')
        phrase 'feature :subject' do |subject|
          subject
        end      
      end    
      language.parse("feature first person")[:result] == 'first person'
    end
    
    it 'supports matching a finite set of words' do
      language = Language.create do |language|
        concept :model, possible_words('Person', 'Friend')
        phrase 'what :model is this' do |model|
          context[:model] = model
        end      
      end    
      language.parse("what Person is this")[:model].should == 'Person'
      language.parse("what Friend is this")[:model].should == 'Friend'
      language.parse("what NoMatch is this")[:model].should be_nil
    end
    
    it 'supports extracting quoted text' do
      language = Language.create do |language|
        concept :criteria, words_in_quotes, :normalize => by_removing_outer_quotes
        phrase "Person with name :criteria" do |criteria|
          context[:name] = criteria
        end
      end
      language.parse("Person with name 'John Adams'")[:name].should == 'John Adams'
    end
  
    it 'supports matching multiple concepts' do
      language = Language.create do |language|
        concept :criteria, words_in_quotes, :normalize => by_removing_outer_quotes
        concept :attribute, any_word
        concept :model, word('Person')      
        phrase "Find :model where :attribute is :criteria" do |model, attribute, criteria|
          context[:model] = model
          context[:attribute] = attribute
          context[:criteria] = criteria
        end
      end
      translation = language.parse("Find Person where name is 'John Adams'")
      translation[:model].should == 'Person'    
      translation[:attribute].should == 'name'    
      translation[:criteria].should == 'John Adams'
    end
    
    it 'supports concepts that have conversion logic in a block' do
      language = Language.create do |language|
        concept :number, any_number, :normalize => as_fixnum
        phrase 'feature :number' do |number|
          number
        end      
      end    
      language.parse("feature 32")[:result] == 32
    end

    it 'should throw an exception when using unknown concept' do    
      proc{ 
        Language.create do |language|
          phrase "Find :bad_concept now" do |bad_concept|
          end
        end 
      }.should raise_error(InvalidConceptError)
    end

    it 'supports phrases with optional words' do
      language = Language.create do |language|
        concept :word, any_word
        phrase 'feature <all> :word' do |word|
          context[:word] = word
        end
      end
      language.parse('feature all events')[:word].should == 'events'
      language.parse('feature events')[:word].should == 'events'
    end
  
    it 'processes command only once where phrases defined first take precedence' do
      language = Language.create do |language|
        concept :word, any_word
        phrase 'first :word' do |word|
          context[:first] = true
        end
        phrase 'first :word' do |word|
          context[:second] = true
        end          
      end
      translation = language.parse('first executed')
      translation[:first].should == true
      translation[:second].should be_nil
    end
  
    it 'supports processing multiple commands separated by period' do
      language = Language.create do |language|
        concept :word, any_word
        phrase 'the first word is :word' do |word|
          words = context[:word].nil? ? [] : context[:word]
          words << word
          context[:word] = words
        end
      end
      statment = 'The first word is word. The first word is help.'
      language.parse(statment)[:word].should == ['word', 'help']
    end
   
    it 'supports setting context when processing command' do
      language = Language.create do |language|
        concept :word, any_word
        phrase 'add the :word to context' do |word|
          context[:word] = word
        end
      end
      language.parse('add the butters to context')[:word].should == 'butters'
    end
   
    it 'supports matching lists of a finite set of words' do
      language = Language.create do |language|
        concept :list, multiple_occurrences_of('one', 'two', 'three', 'four'), :normalize => as_list
        phrase 'add :list to context' do |word|
          context[:word] = word
        end
      end
      language.parse("add one, two and three to context")[:word].should == ['one', 'two', 'three']
    end
    
    it 'supports matching lists of a finite set of words and with other concepts' do
      language = Language.create do |language|
        concept :action,  any_word
        concept :list,    multiple_occurrences_of('one', 'two', 'three', 'four'), :normalize => as_list
        phrase ':action :list to context' do |action, list|
          context[:action] = action
          context[:list] = list
        end
      end
      language.parse("add one, two and three to context")[:action].should == 'add'
      language.parse("add one, two and three to context")[:list].should == ['one', 'two', 'three']
    end
  
    it 'supports an external grammer file' do
      test_grammer = File.expand_path(File.dirname(__FILE__)) + '/../test_grammer.rb'
      language = Language.create(test_grammer)
      language.parse("feature documents")[:result] == 'documents'
    end
   
    it 'supports matching same concept multiple times and adding to an array' do
      pending
      language = Language.create do |language|
        concept :this, any_word
        phrase 'feature :this and :this too' do |this|
          context[:this] = this
        end
      end
      language.parse('feature this and that too')[:this].should == ['that', 'this']    
    end
 
    it 'supports chaining phrases to aggregate results' do
      pending 'chaining removes duplication'
      language = Language.create do |language|
        concept :word, any_word
        featured_phrase = phrase 'feature :word' do |subject|
          subject
        end
        concept :featured, featured_phrase
        phrase 'highlight :word and :featured' do |first_word, featured|
          [first_word, featured]
        end
      end
      language.parse("highlight events and feature documents")[:result].should == ['events', 'documents']
    end
    
    it 'should support optional matches' do
      pending 'phrase find :something <:optional>'
    end
  end
end