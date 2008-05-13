TODO
* arrane model names longes first to shortest to prevent eager eatting
* Open config/hoe.rb
* Update missing details (gem description, dependent gems, etc.)
CHEATSHEET http://www.ilovejackdaniels.com/regular_expressions_cheat_sheet.pdf
Regex http://angryruby.blogspot.com/2007/05/oniguruma-and-named-regexes-in-ruby-18.html

# feature documents tagged with 'NY Roundtable'
# document named 'Finance Tomorrow' is fresh content
# filterable on tags 'NY Roundtable', 'Chicago Roundtable' and 'Popular'
# filterable on event names
# add job board
# add job board with latest 5 posts
# add poll 'What should be our 2009 strategy?'
# add blog 'http://www.bill-gates.com/rss'
# add news for LGE
# show people and highlight my friends

# Structure
# action subject qualifier
# subject qualifier action ?

# Action:
# - feature: determines features collection
# - highlight: styles entity
# - add: enable widget
# - filter: 

# Subjects: (all models - support human name)
# - event
# - person
# - document (alias: asset)

# Qualifiers (any attribute)
# - titled (alias: named)
# - tagged
# - next month / latest (other date parameters)


# FEATURE
# feature document named 'Finance Tomorrow' => Asset.find_by_title('Finance Tomorrow')
# feature latest 3 events => Event.find(:all, :order_by => :start_date, :limit => 3 )

# complexity - representing time


* admin and usrs can share same url endpoint - but need to discuss post V1 - Michael Janosky E&Y
* covered major bucket - SOW


language.create do
  end_of_command_when '.', "\n"
  
  concept :models, :patterns => ['Authors', 'Documents']
  concept :number, :regex => /something/
  concept :number, :models => Author
  #models will alway be turned into a class
  concept :models, :pattern => 'some text'
                   :prepare => as.constant
                   :prepare => by |text|
                    
                   end
  
  concept :part, :phrase => phrase(":model with :attribute ':text'") do |model, attribute, text|
  
  end
  
  phrase [':number latest :model', 'latest :number model'] do |number, model|
    model.find_where
  end.as_concept(:latest)
  
  phrase ['feature :latest', 'feature :part'] do |result|
    contect[:featured] << part
  end
  
  phrase ':number most recent :model' do |number, model|
    model.find_where
  end
  
  phrase "Feature :model with :attribute ':text'" do |model, attribute, text|
    context[:result] << model.find_by_attribute(text)
  end

  phrase "Feature :part" do |part|
    context[:featured] << part
  end
  
  phrase "Highlight :part" do |part|
    context[:highlighted] << part
  end
  
                   
  synonmys_for "Person", 'friends', 
                   
                   as.integer
                   as.date  
  
end

context = semantic_processer.parse('some text')
context[:featured]


== LICENSE:

(The MIT License)

Copyright (c) 2008 FIX

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.