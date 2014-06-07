require 'spec_helper'

module Semr
  describe Language do

    it 'supports word concepts' do
      result = {}
      language = Language.create do |language|
        concept :word, any_word
        phrase 'feature :word' do |word|
          result[:word] = word
        end
      end
      language.parse("feature documents")
      expect(result[:word]).to eq 'documents'
    end

    it 'supports multiple word concepts' do
      result = {}
      language = Language.create do |language|
        concept :subject, word('first person')
        phrase 'feature :subject' do |subject|
          result[:subject] = subject
        end
      end
      language.parse("feature first person")
      expect(result[:subject]).to eq 'first person'
    end

    it 'supports matching a finite set of words' do
      result = {}
      language = Language.create do |language|
        concept :model, possible_words('Person', 'Friend')
        phrase 'what :model is this' do |model|
          result[:model] = model
        end
      end
      language.parse("what Person is this")
      expect(result[:model]).to eq 'Person'
      language.parse("what Friend is this")
      expect(result[:model]).to eq 'Friend'
      result[:model] = nil
      language.parse("what NoMatch is this")
      expect(result[:model]).to be_nil
    end

    it 'supports extracting quoted text' do
      result = {}
      language = Language.create do |language|
        concept :criteria, words_in_quotes, :normalize => by_removing_outer_quotes
        phrase "Person with name :criteria" do |criteria|
          result[:name] = criteria
        end
      end
      language.parse("Person with name 'John Adams'")
      expect(result[:name]).to eq 'John Adams'
    end

    it 'supports matching multiple concepts' do
      result = {}
      language = Language.create do |language|
        concept :criteria, words_in_quotes, :normalize => by_removing_outer_quotes
        concept :attribute, any_word
        concept :model, word('Person')
        phrase "Find :model where :attribute is :criteria" do |model, attribute, criteria|
          result[:model] = model
          result[:attribute] = attribute
          result[:criteria] = criteria
        end
      end
      language.parse("Find Person where name is 'John Adams'")
      expect(result[:model]).to eq 'Person'
      expect(result[:attribute]).to eq 'name'
      expect(result[:criteria]).to eq 'John Adams'
    end

    it 'supports concepts that have conversion logic in a block' do
      result = {}
      language = Language.create do |language|
        concept :number, any_number, :normalize => as_fixnum
        phrase 'feature :number' do |number|
          result[:number] = number
        end
      end
      language.parse("feature 32")
      expect(result[:number]).to eq 32
    end

    it 'should throw an exception when using unknown concept' do
      expect do
        Language.create do |language|
          phrase "Find :bad_concept now" do |bad_concept|
          end
        end
      end.to raise_error(InvalidConceptError)
    end

    it 'supports phrases with optional words' do
      result = {}
      language = Language.create do |language|
        concept :word, any_word
        phrase 'feature <all> :word' do |word|
          result[:word] = word
        end
      end
      language.parse('feature all events')
      expect(result[:word]).to eq 'events'
      language.parse('feature events')
      expect(result[:word]).to eq 'events'
    end

    it 'processes command only once where phrases defined first take precedence' do
      result = {}
      language = Language.create do |language|
        concept :word, any_word
        phrase 'first :word' do |word|
          result[:first] = true
        end
        phrase 'first :word' do |word|
          result[:second] = true
        end
      end
      language.parse('first executed')
      expect(result[:first]).to eq true
      expect(result[:second]).to be_nil
    end

    it 'supports processing multiple commands separated by period' do
      result = {}
      language = Language.create do |language|
        concept :word, any_word
        phrase 'the first word is :word' do |word|
          result[:word] ||= []
          result[:word] << word
        end
      end
      statment = 'The first word is word. The first word is help.'
      language.parse(statment)
      expect(result[:word]).to eq ['word', 'help']
    end

    it 'supports setting result when processing command' do
      result = {}
      language = Language.create do |language|
        concept :word, any_word
        phrase 'add the :word to result' do |word|
          result[:word] = word
        end
      end
      language.parse('add the butters to result')
      expect(result[:word]).to eq 'butters'
    end

    it 'supports matching lists of a finite set of words' do
      result = {}
      language = Language.create do |language|
        concept :list, multiple_occurrences_of('one', 'two', 'three', 'four'), :normalize => as_list
        phrase 'add :list to result' do |word|
          result[:word] = word
        end
      end
      language.parse("add one, two and three to result")
      expect(result[:word]).to eq ['one', 'two', 'three']
    end

    it 'supports matching lists of a finite set of words and with other concepts' do
      result = {}
      language = Language.create do |language|
        concept :action,  any_word
        concept :list,    multiple_occurrences_of('one', 'two', 'three', 'four'), :normalize => as_list
        phrase ':action :list to result' do |action, list|
          result[:action] = action
          result[:list] = list
        end
      end
      language.parse("add one, two and three to result")
      expect(result[:action]).to eq 'add'
      language.parse("add one, two and three to result")
      expect(result[:list]).to eq ['one', 'two', 'three']
    end

    it 'supports an external grammer file' do
      test_grammer = File.expand_path(File.dirname(__FILE__)) + '/../test_grammer.rb'
      language = Language.create(test_grammer)
      language.parse("feature documents")[:result] == 'documents'
    end

    xit 'supports matching same concept multiple times and adding to an array' do
      pending
      result = {}
      language = Language.create do |language|
        concept :this, any_word
        phrase 'feature :this and :this too' do |this|
          result[:this] = this
        end
      end

      language.parse('feature this and that too')
      expect(result[:this]).to eq ['that', 'this']
    end

    xit 'supports chaining phrases to aggregate results' do
      pending 'chaining removes duplication'
      result = {}
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
      language.parse("highlight events and feature documents")
      expect(result[:result]).to eq ['events', 'documents']
    end

    xit 'should support optional matches' do
      pending 'phrase find :something <:optional>'
    end
  end
end
