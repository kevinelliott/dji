# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dji/version'

Gem::Specification.new do |spec|
  spec.name          = 'dji'
  spec.version       = DJI::VERSION
  spec.authors       = ["Kevin Elliott"]
  spec.email         = ["kevin@welikeinc.com"]

  spec.summary       = %q{CLI and Ruby tools for drone-maker DJI's store, account, and more.}
  spec.description   = %q{CLI and Ruby tools for drone-maker DJI's store, account, and more.}
  spec.homepage      = "http://github.com/kevinelliott/dji"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = ['dji']
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'thor', '>= 0.18.1', '< 2.0'
  spec.add_dependency 'nokogiri'

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
