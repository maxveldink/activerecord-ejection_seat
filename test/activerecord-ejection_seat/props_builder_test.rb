# typed: true
# frozen_string_literal: true

require "test_helper"

class PropsBuilderTest < Minitest::Test
  def test_when_model_contains_attributes_not_on_struct_it_builds_correctly
    pet = ComplexPet.new(name: "Sadie", breed: "Brittany", age: 2, pedigree: true)
    builder = PropsBuilder.new(model: pet, target_struct: Types::Pet)

    assert_equal({ name: "Sadie", breed: "Brittany" }, builder.build)
  end

  def test_when_struct_contains_props_not_on_model_it_builds_correctly
    pet = SimplePet.new(breed: "Brittany")
    builder = PropsBuilder.new(model: pet, target_struct: Types::Pet)

    assert_equal({ name: nil, breed: "Brittany" }, builder.build)
  end
end
