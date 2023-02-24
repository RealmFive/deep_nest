# frozen_string_literal: true

require_relative "lib/deep_nest/version"

Gem::Specification.new do |spec|
  spec.name = "deep_nest"
  spec.version = DeepNest::VERSION
  spec.authors = ["Mattie Hansen"]
  spec.email = ["mattie.hansen@realmfive.com"]

  spec.summary = "Recursive methods for ruby structures."
  spec.homepage = "https://github.com/RealmFive/deep-nest"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.2")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|Guardfile|doc|tmp)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'fabrication', '~> 2.30.0'
  spec.add_development_dependency 'guard', '~> 2.18.0'
  spec.add_development_dependency 'guard-rspec', '~> 4.7.3'
  spec.add_development_dependency 'rspec', '~> 3.12.0'
  spec.add_development_dependency 'yard', '~> 0.9.28'
end
