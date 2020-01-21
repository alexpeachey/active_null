# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_null/version'

Gem::Specification.new do |spec|
  spec.name          = 'active_null'
  spec.version       = ActiveNull::VERSION
  spec.authors       = ['alexpeachey']
  spec.email         = ['alex.peachey@gmail.com']
  spec.summary       = %q{Make ActiveRecord null model aware.}
  spec.description   = %q{Make ActiveRecord null model aware.}
  spec.homepage      = 'https://github.com/alexpeachey/active_null'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'naught', '~> 1.0'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'activerecord', '~> 4.2'
  spec.add_development_dependency 'sqlite3', '~> 1.3.6'
  spec.add_development_dependency 'draper', '~> 2.1'
  spec.add_development_dependency 'coveralls'
end
