# typed: strict
# frozen_string_literal: true

module Types
  class Pet < T::Struct
    const :name, String
    const :breed, String
  end
end
