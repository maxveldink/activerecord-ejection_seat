# typed: strict
# frozen_string_literal: true

class Location < ActiveRecord::Base
  ejects_to Types::Location
end