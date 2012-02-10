# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "holdem/version"

Gem::Specification.new do |s|
  s.name        = "holdem"
  s.version     = Holdem::VERSION
  s.authors     = ["paul"]
  s.email       = ["paul@dryule.com"]
  s.homepage    = ""
  s.summary     = %q{Play poker}
  s.description = %q{allows a full holdem gam eto be played out}
  s.files = Dir['lib/**/*.rb']
  s.files += Dir['test/**/*']
  s.require_paths = ["lib"]
end
