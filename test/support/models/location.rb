# typed: strict
# frozen_string_literal: true

class Location < ActiveRecord::Base
  has_many :users

  ejects_to Types::Location
end
