# frozen_string_literal: true

require_relative 'lib/legion/extensions/sqs/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-sqs'
  spec.version       = Legion::Extensions::Sqs::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']

  spec.summary       = 'LEX::Sqs'
  spec.description   = 'Connects Legion to AWS SQS for queue and message management'
  spec.homepage      = 'https://github.com/LegionIO/lex-sqs'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/LegionIO/lex-sqs'
  spec.metadata['documentation_uri'] = 'https://github.com/LegionIO/lex-sqs'
  spec.metadata['changelog_uri'] = 'https://github.com/LegionIO/lex-sqs'
  spec.metadata['bug_tracker_uri'] = 'https://github.com/LegionIO/lex-sqs/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'aws-sdk-sqs', '~> 1.0'
end
