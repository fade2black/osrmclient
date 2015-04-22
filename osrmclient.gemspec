# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'osrmclient/version'

Gem::Specification.new do |spec|
  spec.name          = "osrmclient"
  spec.version       = Osrmclient::VERSION
  spec.authors       = ["Bayram Kuliyev"]
  spec.email         = ["bkuliyev@gmail.com"]

  spec.summary       = %q{Ruby interface to query Open Source Routing Machine servers.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec'

  spec.add_dependency 'typhoeus'
  spec.add_dependency 'faraday'

end
