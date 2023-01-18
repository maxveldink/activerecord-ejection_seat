# typed: strict
# frozen_string_literal: true

class User < ActiveRecord::Base
  belongs_to :location

  ejects_to Types::User
end
