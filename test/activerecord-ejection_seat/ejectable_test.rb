# typed: true
# frozen_string_literal: true

require "test_helper"

class TestEjectable < Minitest::Test
  def test_eject_handles_simple_fields
    location_model = Location.new(name: "Florida")
    location_struct = Types::Location.new(name: "Florida")

    assert_equal location_model.eject, location_struct
  end

  def test_to_struct_is_an_alias_for_eject
    location_model = Location.new(name: "Florida")

    assert_equal location_model.to_struct, location_model.eject
  end
end
