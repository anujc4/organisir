# frozen_string_literal: true

require_relative "lib/organisir/version"

Gem::Specification.new do |spec|
  spec.name          = "organisir"
  spec.version       = Organisir::VERSION
  spec.authors       = ["anujchandra"]
  spec.email         = ["anujc4@gmail.com"]

  spec.summary       = "Gem to organise files based on their filename"
  spec.description   = "Gem to organise files based on their filename"
  spec.homepage      = "https://github.com/anujc4/organisir"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/anujc4/organisir"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  # spec.files = Dir["lib/**/*.rb"]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
