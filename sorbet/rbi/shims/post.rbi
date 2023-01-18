# typed: true
# frozen_string_literal: true

class Post < ActiveRecord::Base
  sig { params(struct: T::Struct).returns(Post) }
  def self.buckle(struct); end

  sig { params(struct: T::Struct).returns(Post) }
  def self.from_struct(struct); end

  sig { returns(T.nilable(String)) }
  def title; end

  sig { returns(T.nilable(String)) }
  def status; end
end
