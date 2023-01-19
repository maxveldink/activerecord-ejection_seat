# typed: strict
# frozen_string_literal: true

require_relative "./post_status"

module Types
  class Post < T::Struct
    include T::Struct::ActsAsComparable

    const :title, String
    const :status, PostStatus
  end
end
