Prerequisites
=============

The semr gem uses the oniguruma library to leverage more mature regular expression features. This library is part of ruby 1.9 but we need to install it if running ruby 1.8.
More info on gem: http://oniguruma.rubyforge.org/

On Windows
1. gem install oniguruma

On Mac
1. Unzip: /install/onig-5.9.1.tar
2. cd to  /install/onig-5.9.1
3. Execute: ./configure
4. Execute: make
5. Execute: sudo make install
6. gem install oniguruma

Basics
======

See the example.rb for an example of creating a language (grammar).

Describe:
  * Language
  * Concept
    - normalizers
    - expressions
  * Phrase


== LICENSE:

(The MIT License)

Copyright (c) 2008 Matthew Deiters

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