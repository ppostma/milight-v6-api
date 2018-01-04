# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "milight/v6/version"

Gem::Specification.new do |spec|
  spec.name          = "milight-v6"
  spec.version       = Milight::V6::VERSION
  spec.authors       = ["Peter Postma"]
  spec.email         = ["peter.postma@gmail.com"]

  spec.summary       = "Ruby API for the Milight Wifi Bridge v6"
  spec.description   = "Ruby API for the Milight Wifi Bridge (or Wifi iBOX controller) version 6."
  spec.homepage      = "https://github.com/ppostma/milight-v6-api"
  spec.license       = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = ["milight"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
