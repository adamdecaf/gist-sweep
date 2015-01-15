# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gist/sweep/version"

Gem::Specification.new do |s|
  s.name        = "gist-sweep"
  s.version     = Gist::Sweep::VERSION
  s.authors     = ["Adam Shannon"]
  s.email       = ["adam@ashannon.us"]
  s.homepage    = ""
  s.summary     = "sweep gists"
  s.description = "Clear our old github gists"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "json"
  s.add_runtime_dependency "github_api"

  s.add_development_dependency "bundler", "~> 1.7"
  s.add_development_dependency "rake", "~> 10.0"
end
