lib = File.expand_path('../lib', __FILE__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'tnw_common/version'

Gem::Specification.new do |spec|
  spec.name          = 'tnw_common'
  spec.version       = TnwCommon::VERSION
  spec.authors       = ['Frank Feng', 'Sebastian Palucha']
  spec.email         = ['frank.feng@york.ac.uk', 'sebastian.palucha@york.ac.uk']

  spec.summary       = 'TNW Common module.'
  spec.description   = 'TNW Common provides re-usable modules, functions and other services for The Northern Way applications.'
  spec.homepage      = 'https://github.com/digital-york/tnw_common'
  spec.license       = 'APACHE2'

  spec.add_dependency 'rsolr'

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-core'
  spec.add_development_dependency 'rspec-rails'
end
