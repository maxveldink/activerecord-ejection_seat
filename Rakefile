# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new do |t|
  t.options = ["-A"]
end

desc "Run tapioca compilers"
task :tapioca do
  sh "bin/tapioca gem"
end

desc "Run Sorbet typechecker"
task :sorbet do
  sh "bundle exec srb tc"
end

task default: %i[rubocop sorbet spec]
