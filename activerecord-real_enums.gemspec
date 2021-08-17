# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activerecord/real_enums/version'

Gem::Specification.new do |spec|
  spec.name          = "activerecord-real_enums"
  spec.version       = Activerecord::RealEnums::VERSION
  spec.authors       = ["Leif Gensert"]
  spec.email         = ["leif@propertybase.com"]
  spec.summary       = "PG Enum support for AcviteRecord "
  spec.description   = %q{Add support for Postgresql Enum type in ActiveRecord}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activemodel"

  spec.add_development_dependency "activerecord", ">= 4.0", "< 5.0"
  spec.add_development_dependency "bundler", "~> 2.2"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
end
