# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gist/sweep/version"

Gem::Specification.new do |s|
  s.name        = "gist-sweep"
  s.version     = Gist::Sweep::VERSION
  s.authors     = ["Adam Shannon"]
  s.email       = ["adam@ashannon.us"]
  s.homepage    = "https://github.com/adamdecaf/gist-sweep"
  s.summary     = "sweep gists"
  s.description = "Clear our old github gists"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.licenses = ["MIT"]

  s.add_runtime_dependency "json", "~> 2.0"
  s.add_runtime_dependency "github_api", "~> 0.14"

  s.add_development_dependency "bundler", "~> 1.13"
  s.add_development_dependency "rake", "~> 12.0"
end
