# typed: strict
# frozen_string_literal: true

class Post < ActiveRecord::Base
  enum :status, { draft: "draft", published: "published" }
  ejects_to Types::Post
end
