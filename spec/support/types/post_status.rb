# typed: true
# frozen_string_literal: true

module Types
  class PostStatus < T::Enum
    enums do
      Draft = new("draft")
      Published = new("published")
    end
  end
end
