# typed: strict
# frozen_string_literal: true

require "active_support/lazy_load_hooks"
require "active_support/dependencies/autoload"
require "activerecord-ejection_seat/ejectable"
require "active_record/base"
require "active_model"
require "bundler"
require "debug"
require "minitest"
require "minitest/test_task"
require "minitest/autorun"
require "pathname"
require "sorbet-runtime"
require "sorbet-struct-comparable"
require "rubocop/rake_task"
require "concurrent"
