# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stracer/version'

Gem::Specification.new do |spec|
  spec.name          = "stracer"
  spec.version       = Stracer::VERSION
  spec.authors       = ["tor"]
  spec.email         = ["torkale@gmail.com"]
  spec.description   = %q{Central point for logging and tracing of system events}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "statsd-ruby"
  spec.add_dependency "log4r"
  spec.add_dependency "log4r-gelf"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rr"
end
