# typed: strict
# frozen_string_literal: true

module Types
  class PostStatus < T::Enum # rubocop:disable Sorbet/MultipleTEnumValues
    enums do
      Draft = new("draft")
    end
  end
end
