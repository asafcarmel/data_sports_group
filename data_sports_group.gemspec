# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'data_sports_group/version'

Gem::Specification.new do |spec|
  spec.name          = "data_sports_group"
  spec.version       = DataSportsGroup::VERSION
  spec.authors       = ["Asaf Carmel"]

  spec.summary       = %q{data sports group API}
  spec.description   = %q{ruby API endpoint to data sports group services}
  spec.homepage      = "https://github.com/asafcarmel/data_sports_group"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "http://mygemserver.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'nokogiri', '~> 1.6.7'
  spec.add_dependency 'rest-client', '~> 1.8.0'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency 'rspec-xml', '~> 0.1.1'
  spec.add_development_dependency 'vcr', '~> 2.9.3'
  spec.add_development_dependency 'webmock', '~> 1.21.0'
  #spec.add_development_dependency 'byebug'
end
