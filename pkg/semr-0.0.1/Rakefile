require 'config/requirements'
require 'config/hoe' # setup Hoe + all gem configuration

Dir['tasks/**/*.rake'].each { |rake| load rake }

Rake::Task[:default].prerequisites.clear #remove testunit
task :default => :spec