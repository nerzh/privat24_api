
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "privat24_api/version"

Gem::Specification.new do |spec|
  spec.name          = "privat24_api"
  spec.version       = Privat24Api::VERSION
  spec.authors       = ["woodcrust"]
  spec.email         = ["emptystamp@gmail.com"]

  spec.summary       = 'This is gem privat24_api'
  spec.description   = 'Gem privat24_api for all ruby projects'
  spec.homepage      = 'https://github.com/woodcrust/privat24_api'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*']
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_runtime_dependency     'rest-client'
  spec.add_runtime_dependency     'nokogiri'
  spec.add_runtime_dependency     'activesupport'

  spec.add_development_dependency "bundler", "~> 1.15"
end
