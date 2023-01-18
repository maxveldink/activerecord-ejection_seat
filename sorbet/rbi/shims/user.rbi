# typed: true
# frozen_string_literal: true

class User < ActiveRecord::Base
  sig { params(struct: T::Struct).returns(User) }
  def self.buckle(struct); end

  sig { params(struct: T::Struct).returns(User) }
  def self.from_struct(struct); end

  sig { returns(T.nilable(String)) }
  def name; end

  sig { returns(T.nilable(Integer)) }
  def age; end

  sig { returns(T.nilable(Location)) }
  def location; end
end
