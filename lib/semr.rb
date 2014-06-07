require "semr/dictionary"
require "semr/translation"
require "semr/expressions"
require "semr/normalizers"
require "semr/language"
require "semr/concept"
require "semr/phrase"
require "semr/extensions/string"
require "semr/extensions/object"
if defined? ActiveRecord
  require "semr/rails/model_inflector"
  require "semr/rails/model_synonym"
  ActiveRecord::Base.extend Semr::Rails::ModelSynonym
end

