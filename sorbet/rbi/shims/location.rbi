# typed: true
# frozen_string_literal: true

class Location < ActiveRecord::Base
  sig { params(struct: T::Struct).returns(Location) }
  def self.buckle(struct); end

  sig { params(struct: T::Struct).returns(Location) }
  def self.from_struct(struct); end

  sig { returns(T.nilable(String)) }
  def name; end
end
