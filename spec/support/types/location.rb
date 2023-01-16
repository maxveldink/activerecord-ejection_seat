# typed: false
# frozen_string_literal: true

require "sorbet-runtime"
require "sorbet-struct-comparable"

module Types
  class Location < T::Struct
    include T::Struct::ActsAsComparable

    const :name, String
  end
end