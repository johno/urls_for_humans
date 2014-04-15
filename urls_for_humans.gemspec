# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'urls_for_humans/version'

Gem::Specification.new do |spec|
  spec.name          = "urls_for_humans"
  spec.version       = UrlsForHumans::VERSION
  spec.authors       = ["John Otander"]
  spec.email         = ["johnotander@gmail.com"]
  spec.summary       = %q{Urls for humans in Rails apps.}
  spec.description   = %q{A delightfully simple way to make your urls friendly to end users, without muddying up the backend.}
  spec.homepage      = "https://github.com/johnotander/urls_for_humans"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
