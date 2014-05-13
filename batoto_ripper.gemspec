# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'batoto_ripper/version'

Gem::Specification.new do |spec|
  spec.name          = "batoto_ripper"
  spec.version       = BatotoRipper::VERSION
  spec.authors       = ["Eric Nelson"]
  spec.email         = ["eric@clean-logix.com"]
  spec.summary       = %q{Batoto manga ripping library}
  spec.description   = %q{This gem is intended to be used with my ripper application as a way to abstract different comic sources away from the models that contain them}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rest-client"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10.3.1"
  spec.add_development_dependency "rspec", ">=3.0.0.beta2"
  spec.add_development_dependency "webmock", "~> 1.18"
  spec.add_development_dependency "vcr", "~> 2.9"


  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-debugger"
end
