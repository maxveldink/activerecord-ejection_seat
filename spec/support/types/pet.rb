# frozen_string_literal: true

require "sorbet-runtime"

module Types
  class Pet < T::Struct
    const :name, String
    const :breed, String
  end
end
