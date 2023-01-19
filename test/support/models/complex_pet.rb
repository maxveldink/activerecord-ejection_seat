# typed: strict
# frozen_string_literal: true

class ComplexPet < ActiveRecord::Base
  ejects_to Types::Pet
end
