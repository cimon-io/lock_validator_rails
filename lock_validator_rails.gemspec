# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lock_validator_rails/version'

Gem::Specification.new do |spec|
  spec.name          = 'lock_validator_rails'
  spec.version       = LockValidatorRails::VERSION
  spec.authors       = %w(aratak K-S-A)
  spec.email         = %w(alexey@cimon.io sergey@cimon.io)

  spec.summary       = 'Validator for model "lock" version'
  spec.description   = 'Implements validation for models by customizable timestamp field (:updated_at by default)'
  spec.homepage      = 'https://github.com/cimon-io/lock_validator_rails'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
