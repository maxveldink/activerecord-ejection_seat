# typed: strict
# frozen_string_literal: true

class SimplePet < ActiveRecord::Base
  ejects_to Types::Pet
end
