# typed: strict
# frozen_string_literal: true

require "sorbet-runtime"
require "sorbet-struct-comparable"

module Types
  class User < T::Struct
    include T::Struct::ActsAsComparable

    const :name, String
    const :age, Integer
    const :location, Location
  end
end