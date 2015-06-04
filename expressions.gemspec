# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'expressions/version'

Gem::Specification.new do |spec|
  spec.name          = "expressions"
  spec.version       = Expressions::VERSION
  spec.authors       = ["Colby Aley"]
  spec.email         = ["colby@aley.me"]
  spec.summary       = %q{Allows users to create and evaluate simple mathematical expressions with changing variables.}
  spec.description   = %q{Aallows users to create and evaluate simple mathematical expressions with changing variables.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
