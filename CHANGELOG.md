# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.2] - 2023-05-16

### Security

- Updates dependencies

## [0.1.0] - 2022-07-22
### Added
- Adds `.ejects_to` to `ActiveRecord::Base` that can be used to specify a Sorbet `T::Struct` that can be converted for that model.
- If `.ejects_to` is specified on a model, adds the `#eject` method to the model to convert to a `T::Struct`. This is aliased to `#to_struct`.
- If `.ejects_to` is specified on a model, adds the `.buckle` method to the model class to initialize from a `T::Struct`. This is aliased to `#from_struct`.
