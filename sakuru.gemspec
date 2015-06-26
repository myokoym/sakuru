# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sakuru/version'

Gem::Specification.new do |spec|
  spec.name          = "sakuru"
  spec.version       = Sakuru::VERSION
  spec.authors       = ["Masafumi Yokoyama"]
  spec.email         = ["myokoym@gmail.com"]
  spec.description   = %q{A tiny full-text search engine by pure Ruby.}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/myokoym/sakuru"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) {|f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency("test-unit", ">= 3.0.0")
  spec.add_development_dependency("bundler")
  spec.add_development_dependency("rake")
end
