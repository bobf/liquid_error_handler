# frozen_string_literal: true

require_relative 'lib/liquid_error_handler/version'

Gem::Specification.new do |spec|
  spec.name          = 'liquid_error_handler'
  spec.version       = LiquidErrorHandler::VERSION
  spec.authors       = ['Bob Farrell']
  spec.email         = ['git@bob.frl']
  spec.licenses      = ['MIT']

  spec.summary       = 'Error handling for Liquid templating language.'
  spec.description   = 'Configure error handling hooks for Liquid.'
  spec.homepage      = 'https://github.com/bobf/liquid_error_handler'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = 'bin'
  spec.executables   = []
  spec.require_paths = ['lib']

  spec.add_dependency 'liquid', '~> 5.0'
  spec.metadata = {
    'rubygems_mfa_required' => 'true'
  }
end
