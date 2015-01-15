# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gist/sweep/version'

Gem::Specification.new do |spec|
  spec.name          = "gist-sweep"
  spec.version       = Gist::Sweep::VERSION
  spec.authors       = ["Adam Shannon"]
  spec.email         = ["adam@ashannon.us"]
  spec.summary       = "sweep gists"
  spec.description   = "Clear our old github gists"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files            = `git ls-files`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
