# rubocop:disable Naming/FileName
# rubocop:enable Naming/FileName
# typed: strict
# frozen_string_literal: true

require_relative "activerecord-ejection_seat/version"
require_relative "activerecord-ejection_seat/props_builder"
require_relative "activerecord-ejection_seat/attributes_builder"

require "active_support/lazy_load_hooks"

ActiveSupport.on_load(:active_record) do
  require "activerecord-ejection_seat/ejectable"
end
