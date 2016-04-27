# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'vagrant-t_functional/version'

Gem::Specification.new do |spec|
  spec.name          = 'vagrant-t_functional'
  spec.version       = VagrantPlugins::T_functional::VERSION
  spec.authors       = ['karthik']
  spec.email         = ['karthik@altiscale.com']
  spec.description   = 't_functional testing on VMs'
  spec.summary       = 't_functional testing on VMs'
  spec.homepage      = ''
  spec.license       = 'Proprietary'

  spec.files         = `git ls-files`.split($RS)
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_development_dependency('bundler',     '~> 1.7')
  spec.add_development_dependency('rake',        '~> 10.0')
  spec.add_development_dependency('rspec',       '~> 3.2.0')
  spec.add_development_dependency('rubocop',     '= 0.28.0')
  spec.add_development_dependency('geminabox',   '~> 0.12.4')
  spec.add_dependency 'aws-sdk', '~> 2'
end
