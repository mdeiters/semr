require 'semr'

language = Semr::Language.create do
  concept :number,    any_number, :normalize => as_fixnum
  concept :greeting,  words('hi', 'goodbye', 'hello')

  phrase 'say :greeting :number times' do |greeting, number|
    number.times { puts greeting }
  end
end

language.parse('say hello 6 times')
# hello
# hello
# hello
# hello
# hello
# hello

language.parse('say goodbye 2 times')
# goodbye
# goodbye
