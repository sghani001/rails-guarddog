require_relative "lib/rails/guarddog/version"
Gem::Specification.new do |spec|
  spec.name          = "rails-guarddog"
  spec.version       = spec.version = Rails::Guarddog::VERSION
  spec.authors       = ["Security Team"]
  spec.email         = ["security@example.com"]
  spec.summary       = "Advanced security checker for Rails apps"
  spec.description   = "Rails GuardDog: Beyond brakeman — AI injection, DoS, supply chain, GraphQL auth, and more"
  spec.homepage      = "https://github.com/example/rails-guarddog"
  spec.license       = "MIT"

  spec.files         = Dir.glob("{lib,bin,config}/**/*") + ["README.md", "LICENSE"]
  spec.bindir        = "bin"
  spec.executables   = ["guarddog"]
  spec.require_paths = ["lib"]

  spec.add_dependency "railties", ">= 6.0"
  spec.add_dependency "parser", "~> 3.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
