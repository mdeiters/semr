require 'rubygems'
require 'oniguruma' #http://oniguruma.rubyforge.org


$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require File.expand_path(File.dirname(__FILE__) + "/semr/translation")
require File.expand_path(File.dirname(__FILE__) + "/semr/expressions")
require File.expand_path(File.dirname(__FILE__) + "/semr/normalizers")
require File.expand_path(File.dirname(__FILE__) + "/semr/language")
require File.expand_path(File.dirname(__FILE__) + "/semr/concept")
require File.expand_path(File.dirname(__FILE__) + "/semr/phrase")
require File.expand_path(File.dirname(__FILE__) + "/semr/extensions/string")
require File.expand_path(File.dirname(__FILE__) + "/semr/extensions/object")
if defined? ActiveRecord
  require File.expand_path(File.dirname(__FILE__) + "/semr/rails/model_inflector")
  require File.expand_path(File.dirname(__FILE__) + "/semr/rails/model_synonym")
  ActiveRecord::Base.extend Semr::Rails::ModelSynonym
end