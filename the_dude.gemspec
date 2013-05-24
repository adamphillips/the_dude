# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','the_dude','version.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'the_dude'
  s.version = TheDude::VERSION
  s.author = 'Adam Phillips'
  s.email = 'adam@29ways.co.uk'
  s.homepage = 'http://github.com/adamphillips/the_dude'
  s.platform = Gem::Platform::RUBY
  s.summary = 'The Dude helps chill out your command line life'
# Add your other files here if you make them
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.require_paths << 'lib'
  s.bindir = 'bin'
  s.executables << 'dude'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_development_dependency('rspec')
  s.add_development_dependency('fakeweb')
  s.add_runtime_dependency('hirb')
end
