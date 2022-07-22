# frozen_string_literal: true

require "pathname"

test_dir = Pathname.new File.dirname(__FILE__)

ENV["RAILS_ENV"] = "test"

require "bundler"
Bundler.setup

require "active_record"
require "active_record/database_configurations"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = :random
end

yaml_config = if RUBY_VERSION >= "3.0.0"
                YAML.safe_load_file(test_dir.join("support/database.yml"), aliases: true)
              else
                YAML.load_file(test_dir.join("support/database.yml"))
              end
config = ActiveRecord::DatabaseConfigurations::HashConfig.new("test", "sqlite3", yaml_config)
ActiveRecord::Base.configurations.configurations << config

require "activerecord-ejection_seat"
ActiveRecord::Base.establish_connection :test

require test_dir.join("support/schema/version").to_s
require test_dir.join("support/schema/test_schema").to_s

Dir["#{File.dirname(__FILE__)}/support/types/**/*.rb"].sort.each { |file| require file }
Dir["#{File.dirname(__FILE__)}/support/models/**/*.rb"].sort.each { |file| require file }
