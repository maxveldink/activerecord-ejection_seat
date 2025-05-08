# typed: strict
# frozen_string_literal: true

require "minitest/autorun"

require "pathname"

test_dir = Pathname.new File.dirname(__FILE__)

ENV["RAILS_ENV"] = "test"

require "bundler"
Bundler.setup
require "debug"

require "active_record"
require "active_record/database_configurations"
require "active_record/schema"
require "active_record/migration"
require "sorbet-struct-comparable"

yaml_config = YAML.safe_load_file(test_dir.join("support/database.yml"), aliases: true)
config = ActiveRecord::DatabaseConfigurations::HashConfig.new("test", "sqlite3", yaml_config)
ActiveRecord::Base.configurations.configurations << config

require "activerecord-ejection_seat"
ActiveRecord::Base.establish_connection :test

require test_dir.join("support/schema/version").to_s
require test_dir.join("support/schema/test_schema").to_s

Dir["#{File.dirname(__FILE__)}/support/types/**/*.rb"].each { |file| require file }
Dir["#{File.dirname(__FILE__)}/support/models/**/*.rb"].each { |file| require file }
