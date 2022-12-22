# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in activerecord-ejection_seat.gemspec
gemspec

group :development do
  gem "rake"
  gem "rubocop"
  gem "rubocop-rake"
  gem "rubocop-rspec"
  gem "rubocop-sorbet"
  gem "sorbet"
  gem "spoom", require: false
  gem "tapioca", require: false

  gem "ruby-lsp"
end

group :development, :test do
  gem "rspec"
  gem "sorbet-runtime"
  gem "sorbet-struct-comparable"
  gem "sqlite3"

  gem "debug"
end
