Gem::Specification.new do |s|
  s.name               = "semr"
  s.version            = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matthew Deiters","Bryan Goldstein"]
  s.date = %q{2010-04-03}
  s.description = %q{A simple DSL for defining a language}
  s.email = %q{brysgo@gmail.com}
  s.files = Dir.glob("lib/**/*") + ["Rakefile"]
  s.test_files = Dir.glob("spec/lib/**/*") + ["spec/test_grammer.rb", "spec/spec_helper.rb"]
  s.add_development_dependency "rspec"
  s.add_development_dependency "mocha"
  s.add_development_dependency "rails"
  s.homepage = %q{http://rubygems.org/gems/semr}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{0.3.0}
  s.summary = %q{A simple DSL for defining a language}
  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('0.3.0') then
    else
    end
  else
  end
end

