# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dune/admin/version'

Gem::Specification.new do |spec|
  spec.name          = 'dune-admin'
  spec.version       = Dune::Admin::VERSION
  spec.authors       = ['Pierre Legrand']
  spec.email         = %w(legrand.work@gmail.com)
  spec.summary       = 'Dune Admin.'
  spec.description   = 'This is the admin of dune-investissement'
  spec.homepage      = 'https://github.com/dune/dune-admin'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency             'rails',              '~> 4.0'
  spec.add_dependency             'best_in_place',      '~> 3.0.0.rc1'
  spec.add_dependency             'postgres-copy',      '~> 0.8.0'
  spec.add_development_dependency 'rake',               '~> 10.2'
  spec.add_development_dependency 'rspec-rails',        '~> 2.14'
  spec.add_development_dependency 'factory_girl_rails', '~> 4.3'
end
