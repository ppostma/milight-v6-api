# frozen_string_literal: true

require_relative "lib/milight/v6/version"

Gem::Specification.new do |spec|
  spec.name          = "milight-v6"
  spec.version       = Milight::V6::VERSION
  spec.authors       = ["Peter Postma"]
  spec.email         = ["peter.postma@gmail.com"]

  spec.summary       = "Ruby API for the Milight Wifi Bridge v6"
  spec.description   = "Ruby API for the Milight Wifi Bridge (or Wifi iBOX controller) version 6."
  spec.homepage      = "https://github.com/ppostma/milight-v6-api"
  spec.license       = "MIT"

  spec.metadata      = { 'rubygems_mfa_required' => 'true' }

  # Specify which files should be added to the gem when it is released.
  spec.files         = Dir['LICENSE.txt', 'README.md', 'lib/**/*']

  spec.executables   = ["milight"]
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 3.2.0'

  spec.add_dependency "logger"

  spec.add_development_dependency "bundler", "~> 4.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
