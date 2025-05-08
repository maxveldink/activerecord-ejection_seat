# typed: true
# frozen_string_literal: true

require "test_helper"

class AttributesBuilderTest < Minitest::Test
  def setup
    @pet = Types::Pet.new(name: "Sadie", breed: "Brittany")
  end

  def test_when_struct_contains_props_not_on_model_it_builds_correctly
    builder = AttributesBuilder.new(struct: @pet, target_model: SimplePet)

    assert_equal({ "breed" => "Brittany" }, builder.build)
  end

  def test_when_model_contains_attributes_not_on_struct_it_builds_correctly
    builder = AttributesBuilder.new(struct: @pet, target_model: ComplexPet)

    assert_equal({ "breed" => "Brittany", "name" => "Sadie" }, builder.build)
  end

  def test_when_model_contains_belongs_to_association_it_build_correctly
    user = Types::User.new(name: "Max", age: 28, location: Types::Location.new(name: "Florida"), is_active: false)
    builder = AttributesBuilder.new(struct: user, target_model: User)

    built_attributes = builder.build

    assert_equal "Max", built_attributes["name"]
    assert_equal 28, built_attributes["age"]
    assert_equal "Florida", built_attributes["location"].name
  end
end
