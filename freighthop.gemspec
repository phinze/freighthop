# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'freighthop/version'

Gem::Specification.new do |spec|
  spec.name          = 'freighthop'
  spec.version       = Freighthop::VERSION
  spec.authors       = ['Paul Hinze']
  spec.email         = ['paul.t.hinze@gmail.com']
  spec.description   = %q{Vagrant on Rails: quickly spin up a Vagrant VM to serve your rack-compatible app.}
  spec.summary       = %q{Vagrant on Rails: quickly spin up a Vagrant VM to serve your rack-compatible app.}
  spec.homepage      = 'https://github.com/phinze/freighthop'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'guard-shell'

  spec.add_dependency 'librarian-puppet'
end
