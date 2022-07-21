# frozen_string_literal: true

require_relative "lib/activerecord-ejection_seat/version"

Gem::Specification.new do |spec|
  spec.name = "activerecord-ejection_seat"
  spec.version = ActiveRecord::EjectionSeat::VERSION
  spec.authors = ["Max VelDink"]
  spec.email = ["max@audaciousaardvark.com"]

  spec.summary = "Eject from an ActiveRecord model to a Sorbet T::Struct, or buckle back in."
  spec.description = "When working with ActiveRecord models, sometimes you want to eject to a simpler, safer object. \
                      Enter Sorbet's T::Struct. This gem makes it much easier to target a \
                      Sorbet T::Struct and eject from an ActiveRecord model into the struct. \
                      It also allows you to buckle in from a simple struct to a new ActiveRecord model instance."
  spec.homepage = "https://github.com/AudaciousAardvark/activerecord-ejection_seat"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/AudaciousAardvark/activerecord-ejection_seat/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activerecord", ">= 5.2"
end
