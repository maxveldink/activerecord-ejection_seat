# typed: strict
# frozen_string_literal: true

module Types
  class Location < T::Struct
    include T::Struct::ActsAsComparable

    const :name, String
  end
end
