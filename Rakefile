require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec')

task :default => :spec

task :example do |t|
  puts `ruby -r semr -I ./lib ./example.rb`
end
