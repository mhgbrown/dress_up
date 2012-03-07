# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dress_up/version"

Gem::Specification.new do |s|
  s.name        = "dress_up"
  s.version     = DressUp::VERSION
  s.authors     = ["Morgan Brown"]
  s.email       = ["brown.mhg@gmail.com"]
  s.homepage    = "https://github.com/mhgbrown/dress_up"
  s.summary     = "Enable and disable sets of method overrides"
  s.description = %q{TODO: Write a gem description}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rake"
  s.add_development_dependency "rspec"
end
